require "spec_helper"

describe "VPLHTTPResponseBase" do
  
  # ===== CONTENT TYPES ================================================================================================
  
  # ----- XML ----------------------------------------------------------------------------------------------------------
  
  describe ".isXMLContentType:" do
    
    it "should return YES when provided 'text/xml'" do
      VPLHTTPResponseBase.isXMLContentType('text/xml').should == true
    end
    
    it "should return YES when provided 'application/xml'" do
      VPLHTTPResponseBase.isXMLContentType('application/xml').should == true
    end
    
    it "should return YES when provided 'image/svg+xml'" do
      VPLHTTPResponseBase.isXMLContentType('image/svg+xml').should == true
    end
    
    it "should return NO when provided a non-XML content type" do
      VPLHTTPResponseBase.isXMLContentType('text/html').should == false
    end
    
    describe "when a charset is included" do
      
      it "should still detect the proper content type" do
        VPLHTTPResponseBase.isXMLContentType('image/svg+xml; charset=utf8').should == true
        VPLHTTPResponseBase.isXMLContentType('text/plain; charset=xml').should == false
      end
      
    end
    
  end
  
  # ----- HTML ---------------------------------------------------------------------------------------------------------
  
  describe ".isHTMLContentType:" do
    
    it "should return YES when provided 'text/html'" do
      VPLHTTPResponseBase.isHTMLContentType('text/html').should == true
    end
    
    it "should return YES when provided 'application/xhtml'" do
      VPLHTTPResponseBase.isHTMLContentType('application/xhtml').should == true
    end
    
    it "should return YES when provided 'application/xhtml+xml'" do
      VPLHTTPResponseBase.isHTMLContentType('application/xhtml+xml').should == true
    end
    
    it "should return NO when provided any other content type" do
      VPLHTTPResponseBase.isHTMLContentType('text/xml').should == false
    end
    
  end
  
  # ----- JSON ---------------------------------------------------------------------------------------------------------
  
  describe ".isJSONContentType:" do
    
    it "should return YES when provided 'application/json'" do
      VPLHTTPResponseBase.isJSONContentType('application/json').should == true
    end
    
    it "should return YES when provided 'application/x-json'" do
      VPLHTTPResponseBase.isJSONContentType('application/x-json').should == true
    end
    
    it "should return YES when provided 'text/json'" do
      VPLHTTPResponseBase.isJSONContentType('text/json').should == true
    end
    
    it "should return YES when provided 'text/x-json'" do
      VPLHTTPResponseBase.isJSONContentType('text/json').should == true
    end
    
    it "should return NO when provided any other content type" do
      VPLHTTPResponseBase.isJSONContentType('text/xml').should == false
    end
    
  end
  
  # ----- PLAIN TEXT ---------------------------------------------------------------------------------------------------
  
  describe ".isPlainTextContentType:" do
    
    it "should return YES when provided 'text/plain'" do
      VPLHTTPResponseBase.isPlainTextContentType('text/plain').should == true
    end
    
    it "should return NO when provided any other content type" do
      VPLHTTPResponseBase.isPlainTextContentType('text/xml').should == false
    end
    
  end
  
end