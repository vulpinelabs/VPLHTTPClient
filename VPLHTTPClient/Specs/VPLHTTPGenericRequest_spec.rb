require 'spec_helper'

describe "VPLHTTPGenericRequest" do
  
  describe "#initWithURLString:" do
    
    before(:each) do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString('http://www.pivotaltracker.com/')
    end
    
    it "should initialize the #URLString and default #requestMethod to 'GET'" do
      @request.URLString.should == 'http://www.pivotaltracker.com/'
      @request.requestMethod.should == 'GET'
    end
    
  end
  
  # ===== URL ==============================================================================================================
  
  describe "#URL" do
    
    it "should return an NSURL representing the request's URL" do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString('http://www.pivotaltracker.com/')
      @request.URL.isEqual(NSURL.URLWithString('http://www.pivotaltracker.com/')).should == true
    end
    
  end
  
end