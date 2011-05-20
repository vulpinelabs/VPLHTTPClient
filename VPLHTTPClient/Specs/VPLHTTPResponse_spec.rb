require 'spec_helper'

describe "VPLHTTPResponse" do
  
  describe "#initWithStatusCode:body:contentType:" do
    
    before(:each) do
      @body = NSData.data
      @response = VPLHTTPResponse.alloc.initWithStatusCode(200, body:@body, contentType:"text/plain; charset=utf8")
    end
    
    it "should initialize the #statusCode, #body, and #contentType properties" do
      @response.statusCode.should == 200
      @response.body.should equal(@body)
      @response.contentType.should == "text/plain; charset=utf8"
    end
    
  end
  
  # ===== RESPONSE HELPERS =============================================================================================
  
  describe ".response" do
    
    before(:each) do
      @response = VPLHTTPResponse.response
    end
    
    it "should return an empty response with a 200 status code" do
      @response.statusCode.should == 200
      @response.body.isEqualToData(NSData.data).should == true
      @response.contentType.should == "text/plain"
    end
    
  end
  
  describe ".responseWithXML:" do
    
    before(:each) do
      @xml_string = "<?xml version='1.0' ?><document />"
      @response = VPLHTTPResponse.responseWithXML(@xml_string)
    end
    
    it "should return a VPLHTTPResponse with an XML body and appropriate headers" do
      @response.statusCode.should == 200
      @response.body.isEqualToData(@xml_string.dataUsingEncoding(NSUTF8StringEncoding))
      @response.contentType.should == "application/xml; charset=utf8"
    end
    
  end
  
end