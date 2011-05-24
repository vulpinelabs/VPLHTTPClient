require "spec_helper"

describe "VPLASIHTTPRequest" do
  before(:each) do
    @request = VPLASIHTTPRequest.alloc.initWithURLString("http://localhost.localdomain/")
  end
  
  # ===== REQUEST METHOD ===============================================================================================
  
  describe "#requestMethod" do
    
    it "should default to 'GET'" do
      @request.requestMethod.should == "GET"
    end
    
  end
  
  # ===== URL ==========================================================================================================
  
  describe "#requestURLString" do
    
    it "should return the URL of the request as a string" do
      @request.requestURLString.should == "http://localhost.localdomain/"
    end
    
  end
  
  # ===== HEADERS ======================================================================================================
  
  describe "#addRequestHeader:value:" do
    
    before(:each) do
      @request.addRequestHeader('X-Emotion', value:'ambivalent')
    end
    
    it "should set the request header" do
      @request.requestHeaders['X-Emotion'].should == "ambivalent"
    end
    
  end
  
  # ===== AUTHENTICATION ===============================================================================================
  
  describe "#setUsername:password:" do
    
    before(:each) do
      @request.setUsername("christian@nerdyc.com", password:"secret!")
    end
    
    it "should set the username and password of the request" do
      @request.username.should == "christian@nerdyc.com"
      @request.password.should == "secret!"
    end
    
  end
  
end