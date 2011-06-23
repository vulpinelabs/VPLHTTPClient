require 'spec_helper'

describe "VPLHTTPGenericRequest" do
  
  describe "#initWithURLString:" do
    
    before(:each) do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString('http://localhost.localdomain/')
    end
    
    it "should initialize the #URLString and default #requestMethod to 'GET'" do
      @request.requestURLString.should == 'http://localhost.localdomain/'
      @request.requestMethod.should == 'GET'
    end
    
  end
  
  # ===== URL ==========================================================================================================
  
  describe "#requestURL" do
    
    it "should return an NSURL representing the request's URL" do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString('http://localhost.localdomain/')
      @request.requestURL.isEqual(NSURL.URLWithString('http://localhost.localdomain/')).should == true
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
  
  # ===== REQUEST BODY =================================================================================================
  
  describe "#setRequestBody:" do
    
    before(:each) do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString("http://localhost.localdomain")
      
      @data = "<?xml version='1.0' ?><content />".dataUsingEncoding(NSUTF8StringEncoding)
      @request.requestBody = @data
    end
    
    it "should set the ASIHTPRequest's postBody" do
      @request.requestBody.isEqualToData(@data).should == true
    end
    
  end
  
  # ===== REQUEST TIMEOUT ==============================================================================================
  
  describe "#requestTimeout" do
    
    before(:each) do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString("http://localhost.localdomain")
    end
    
    it "should default to 60 seconds" do
      @request.requestTimeout.should == 60.0
    end
    
  end
  
  describe "#setRequestTimeout" do
    before(:each) do
      @request = VPLHTTPGenericRequest.alloc.initWithURLString("http://localhost.localdomain")
    end
    
    before(:each) do
      @request.setRequestTimeout(15.0)
    end
    
    it "should update the request timeout" do
      @request.requestTimeout.should == 15.0
    end
    
  end
  
end