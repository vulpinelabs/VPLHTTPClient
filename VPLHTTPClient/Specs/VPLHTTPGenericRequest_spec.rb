require 'spec_helper'

describe "VPLHTTPGenericRequest" do
  
  describe "#initWithURLString:" do
    
    before(:each) do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString('http://localhost.localdomain/')
    end
    
    it "should initialize the #URLString and default #requestMethod to 'GET'" do
      @request.URLString.should == 'http://localhost.localdomain/'
      @request.requestMethod.should == 'GET'
    end
    
  end
  
  # ===== URL ==========================================================================================================
  
  describe "#URL" do
    
    it "should return an NSURL representing the request's URL" do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString('http://localhost.localdomain/')
      @request.URL.isEqual(NSURL.URLWithString('http://localhost.localdomain/')).should == true
    end
    
  end
  
  # ===== AUTHENTICATION ===============================================================================================
  
  describe "#setUsername:password:" do
    
    before(:each) do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString("http://localhost.localdomain")
      @request.setUsername("christian@nerdyc.com", password:"secret!")
    end
    
    it "should set the username and password fields" do
      @request.username.should == "christian@nerdyc.com"
      @request.password.should == "secret!"
    end
    
  end
  
end