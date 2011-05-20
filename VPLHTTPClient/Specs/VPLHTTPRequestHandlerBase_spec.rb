require "spec_helper"

describe "VPLHTTPRequestHandlerBase" do
  
  before(:each) do
    @accumulator = VPLRequestAccumulator.new
    @request = VPLHTTPRequest.alloc.initWithURLString("http://localhost.localdomain/path/to/resource")
  end
  
  describe "#canPerformRequest:" do
    
    it "should return NO" do
      VPLHTTPRequestHandlerBase.new.canPerformRequest(@request).should == false
    end
    
  end
  
  describe "#performRequest:success:error" do
    
    it "should provide a VPLHTTPRequestNotPerformed error to the errorCallback" do
      VPLHTTPRequestHandlerBase.new.performRequest(@request,
                                                  success:@accumulator.success_callback,
                                                  error:@accumulator.error_callback)
      @accumulator.error.should_not be_nil
      @accumulator.error.domain.should == VPLHTTPErrorDomain
      @accumulator.error.code.should == VPLHTTPRequestNotPerformedError
    end
    
  end
  
end