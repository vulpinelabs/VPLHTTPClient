require 'spec_helper'

describe "VPLHTTPClient" do
  
  before(:each) do
    @client = VPLHTTPClient.alloc.init
  end
  
  # ===== REQUEST HANDLERS =================================================================================================
  
  describe "#isRequestHandlerRegistered:" do
    
    before(:each) do
      @request_handler = VPLHTTPGenericRequestHandler.new
    end
    
    it "should return NO when the handler has not been registered" do
      @client.isRequestHandlerRegistered(@request_handler).should == false
    end
    
    it "should return NO when provided nil" do
      @client.isRequestHandlerRegistered(nil).should == false
    end
    
  end
  
  describe "#appendRequestHandler:" do
    
    before(:each) do
      @request_handler = VPLHTTPGenericRequestHandler.new
    end
    
    it "should add the request handler to the end of the handler queue" do
      @client.appendRequestHandler(@request_handler)
      @client.isRequestHandlerRegistered(@request_handler).should == true
    end
    
  end
  
  describe "#prependRequestHandler:" do
    
    before(:each) do
      @request_handler = VPLHTTPGenericRequestHandler.new
    end
    
    it "should add the request handler to the beginning of the handler queue" do
      @client.prependRequestHandler(@request_handler)
      @client.isRequestHandlerRegistered(@request_handler).should == true
    end
    
  end
  
  describe "#removeRequestHandler:" do
    
    before(:each) do
      @request_handler = VPLHTTPGenericRequestHandler.new
      @client.appendRequestHandler(@request_handler)
      @client.removeRequestHandler(@request_handler)
    end
    
    it "should remove the handler from the handler queue" do
      @client.isRequestHandlerRegistered(@request_handler).should == false
    end
    
  end
  
  # ===== REQUEST DISPATCH =================================================================================================
  
  describe "#performRequest:success:error:" do
    
    before(:each) do
      @accumulator = VPLRequestAccumulator.new
      
      @empty_handler = VPLHTTPGenericRequestHandler.alloc.init
      
      @request = VPLHTTPRequest.alloc.initWithURLString("http://localhost.localdomain/path/to/resource")
      
      @error_handler = VPLHTTPGenericRequestHandler.alloc.initWithError(
        NSError.errorWithDomain("TKErrorRequestHandler", code:1, userInfo:{ :request => @request })
      )
      
      @response = VPLHTTPResponse.response
      @success_handler = VPLHTTPGenericRequestHandler.alloc.initWithResponse(@response)
    end
    
    describe "when request handlers are present" do
      
      before(:each) do
        @client.appendRequestHandler(@empty_handler)
        @client.appendRequestHandler(@error_handler)
        @client.appendRequestHandler(@success_handler)
      end
      
      it "should allow each request handler to handle the request in order of registration" do
        @accumulator = VPLRequestAccumulator.new
        @client.performRequest(@request, success:@accumulator.success_callback, error:@accumulator.error_callback)
        
        @accumulator.error.should_not be_nil
        @accumulator.response.should be_nil
      end
      
    end
    
    describe "when no request handlers can handle the request" do
      
      before(:each) do
        @original_network_requests_enabled = VPLHTTPClient.networkRequestsEnabled
      end
      
      after(:each) do
        VPLHTTPClient.setNetworkRequestsEnabled(@original_network_requests_enabled)
      end
      
      describe "and network requests have not been disabled" do
        
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
      
      describe "but network requests are disabled" do
        
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
      @request = VPLHTTPRequest.alloc.initWithURLString("http://localhost.localdomain/path/to/resource")
      
      @response = VPLHTTPResponse.response
      @request_error = nil
      @response_data = nil
      
      VPLHTTPClient.registerResponse(@response, forURI:"http://localhost.localdomain/path/to/resource")
    end
    
    it "should register a handler for the given URI that returns the given response" do
      @client.performRequest(@request,
                             success:Proc.new { |response| @response_data = @response.body },
                             error:Proc.new { |error| @request_error = error })
                             
      @request_error.should == nil
      @response_data.should equal(@response.body)
    end
    
    it "should only handle requests for the given URI" do
      lambda {
        other_request = VPLHTTPRequest.alloc.initWithURLString("http://localhost.localdomain/path/to/other/resource")
        @client.performRequest(other_request, success:Proc.new { |response| }, error:Proc.new { |error| })
      }.should raise_error
    end
    
  end
  
end