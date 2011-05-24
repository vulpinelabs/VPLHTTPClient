require 'spec_helper'

describe "VPLHTTPGenericResponse" do
  
  describe "#initWithResponseCode:body:contentType:" do
    
    before(:each) do
      @body = NSData.data
      @response = VPLHTTPGenericResponse.alloc.initWithResponseCode(200,
                                                                    body:@body,
                                                                    contentType:"text/plain; charset=utf8")
    end
    
    it "should initialize the #responseCode, #body, and #contentType properties" do
      @response.responseCode.should == 200
      @response.responseBody.should equal(@body)
      @response.responseContentType.should == "text/plain; charset=utf8"
    end
    
  end
  
  # ===== RESPONSE HELPERS =============================================================================================
  
  describe ".response" do
    
    before(:each) do
      @response = VPLHTTPGenericResponse.response
    end
    
    it "should return an empty response with a 200 status code" do
      @response.responseCode.should == 200
      @response.responseBody.isEqualToData(NSData.data).should == true
      @response.responseContentType.should == "text/plain"
    end
    
  end
  
  describe ".responseWithXML:" do
    
    before(:each) do
      @xml_string = "<?xml version='1.0' ?><document />"
      @response = VPLHTTPGenericResponse.responseWithXML(@xml_string)
    end
    
    it "should return a VPLHTTPResponse with an XML body and appropriate headers" do
      @response.responseCode.should == 200
      @response.responseBody.isEqualToData(@xml_string.dataUsingEncoding(NSUTF8StringEncoding))
      @response.responseContentType.should == "application/xml; charset=utf8"
    end
    
  end
  
end