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
  
  # ===== REQUEST BODY =================================================================================================
  
  describe "#setRequestBody:" do
    
    before(:each) do
      @data = "<?xml version='1.0' ?><content />".dataUsingEncoding(NSUTF8StringEncoding)
      @request.requestBody = @data
    end
    
    it "should set the ASIHTPRequest's postBody" do
      @request.requestBody.isEqualToData(@data).should == true
      @request._httpRequest.postBody.isEqualToData(@data).should == true
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
  
  # ===== REQUEST TIMEOUT ==============================================================================================
  
  describe "#requestTimeout" do
    
    it "should default to ASIHTTPRequest.defaultTimeOutSeconds" do
      @request.requestTimeout.should == ASIHTTPRequest.defaultTimeOutSeconds
    end
    
  end
  
  describe "#setRequestTimeout" do
    
    before(:each) do
      @request.setRequestTimeout(42.0)
    end
    
    it "should update the request timeout" do
      @request.requestTimeout.should == 42.0
    end
    
  end
  
  
end