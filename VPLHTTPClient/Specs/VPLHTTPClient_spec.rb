require 'spec_helper'

describe "VPLHTTPClient" do
  
  before(:each) do
    @client = VPLHTTPClient.alloc.init
  end
  
  # ===== REQUEST DISPATCH =================================================================================================
  
  describe "#performRequest:success:error:" do
    
    before(:each) do
      @original_network_requests_enabled = VPLHTTPClient.networkRequestsEnabled
    end
    
    after(:each) do
      VPLHTTPClient.setNetworkRequestsEnabled(@original_network_requests_enabled)
    end
      
    before(:each) do
      @accumulator = VPLRequestAccumulator.new
      
      @empty_handler = VPLHTTPGenericRequestHandler.alloc.init
      
      @request = VPLHTTPGenericRequest.alloc.initWithURLString("http://localhost.localdomain/path/to/resource")
      
      @error_handler = VPLHTTPGenericRequestHandler.alloc.initWithError(
        NSError.errorWithDomain("TKErrorRequestHandler", code:1, userInfo:{ :request => @request })
      )
      
      @response = VPLHTTPGenericResponse.response
      @success_handler = VPLHTTPGenericRequestHandler.alloc.initWithResponse(@response)
    end
    
    describe "when network requests have not been disabled" do
        
      before(:each) do
        VPLHTTPClient.setNetworkRequestsEnabled(true)
      end
      
      it "should provide a VPLHTTPRequestNotPerformed error to the errorCallback" do
        VPLHTTPClient.new.performRequest(@request,
                                        success:@accumulator.success_callback,
                                        error:@accumulator.error_callback)
        @accumulator.error.should_not be_nil
        @accumulator.error.domain.should == VPLHTTPErrorDomain
        @accumulator.error.code.should == VPLHTTPRequestNotPerformedError
      end
      
    end
    
    describe "when network requests are disabled" do
      
      before(:each) do
        VPLHTTPClient.setNetworkRequestsEnabled(false)
      end
      
      it "should raise an exception when an unregistered request is made" do
        lambda { 
          @client.performRequest(@request, success:@accumulator.success_callback, error:@accumulator.error_callback) 
        }.should raise_error
      end
      
    end
    
  end
  
  # ===== NETWORK REQUESTS =============================================================================================
  
  describe ".setNetworkRequestsEnabled:" do
    
    before(:each) do
      @network_requests_enabled = VPLHTTPClient.networkRequestsEnabled
    end
    
    after(:each) do
      VPLHTTPClient.setNetworkRequestsEnabled(@network_requests_enabled)
    end
    
    it "should enable/disable requests to out-of-process handlers" do
      VPLHTTPClient.setNetworkRequestsEnabled(false)
      VPLHTTPClient.networkRequestsEnabled.should == false
      
      VPLHTTPClient.setNetworkRequestsEnabled(true)
      VPLHTTPClient.networkRequestsEnabled.should == true
    end
    
  end
  
  # ===== URI REGISTRATION =============================================================================================
  
  describe ".registerResponse:forURI:" do
    
    before(:each) do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString("http://localhost.localdomain/path/to/resource")
      
      @response = VPLHTTPGenericResponse.response
      @request_error = nil
      @response_data = nil
      
      VPLHTTPClient.registerResponse(@response, forURI:"http://localhost.localdomain/path/to/resource")
    end
    
    it "should register a handler for the given URI that returns the given response" do
      @client.performRequest(@request,
                             success:Proc.new { |response| @response_data = @response.responseBody },
                             error:Proc.new { |error| @request_error = error })
                             
      @request_error.should == nil
      @response_data.should equal(@response.responseBody)
    end
    
    it "should only handle requests for the given URI" do
      lambda {
        other_request = VPLHTTPGenericRequest.alloc.initWithURLString("http://localhost.localdomain/path/to/other/resource")
        @client.performRequest(other_request, success:Proc.new { |response| }, error:Proc.new { |error| })
      }.should raise_error
    end
    
  end
  
  # ===== REQUEST GENERATION ===========================================================================================
  
  describe "#prepareGETRequestForURLString:" do
    
    before(:each) do
      @request = @client.prepareGETRequestForURLString("https://localhost.localdomain/path/to/resource?filter=yes")
    end
    
    it "should return a GET request for the given URL" do
      @request.requestURLString.should == "https://localhost.localdomain/path/to/resource?filter=yes"
      @request.requestMethod.should == "GET"
    end
    
  end
  
  describe "#prepareRequestForURLString:withMethod:" do
    
    before(:each) do
      @client.defaultRequestTimeout = 53.0
      @request = @client.prepareRequestForURLString("https://localhost.localdomain/path/to/resource?filter=yes",
                                                    withMethod:"HEAD")
    end
    
    it "should return a request for the specified URL using the given method" do
      @request.requestURLString.should == "https://localhost.localdomain/path/to/resource?filter=yes"
      @request.requestMethod.should == "HEAD"
    end
    
    it "should assign the default timeout" do
      @request.requestTimeout.should == 53.0
    end
    
  end
  
  # ===== REQUEST TIMEOUT ==============================================================================================
  
  describe "#defaultRequestTimeout" do
    
    it "should default to 60 seconds" do
      @client.defaultRequestTimeout.should == 60.0
    end
    
  end
  
end