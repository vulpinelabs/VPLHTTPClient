require "spec_helper"

describe "VPLASIHTTPResponse" do
  
  describe ".errorWithASIError:" do
    
    before(:each) do
      @asi_error = NSError.errorWithDomain(NetworkRequestErrorDomain,
                                           code:ASIRequestTimedOutErrorType,
                                           userInfo:nil)
      @vpl_error = VPLASIHTTPResponse.errorWithASIError(@asi_error)
    end
    
    it "should return an error in the VPLHTTPError domain" do
      @vpl_error.domain.should == VPLHTTPErrorDomain
    end
    
  end
  
end