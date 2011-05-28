require 'spec_helper'

describe "VPLHTTPGenericRequestHandler" do
  
  describe "#canPerformRequest:" do
    
    before(:each) do
      @handler = VPLHTTPGenericRequestHandler.alloc.init
      @handler.response = VPLHTTPGenericResponse.response
      
      @request = VPLHTTPGenericRequest.alloc.initWithURLString("http://www.example.com/path/to/resource")
    end
    
    describe "when #requestPredicate is nil" do
      
      it "should return YES if a #response or #error has been set" do
        @handler.canPerformRequest(@request).should == true
      end
      
      it "should return NO if neither #response or #error has been set" do
        @handler.response = nil
        @handler.canPerformRequest(@request).should == false
      end
      
    end
    
    describe "when a #requestPredicate exists" do
      
      before(:each) do
        @predicate = NSPredicate.predicateWithFormat("requestURLString == %@",
                                                     argumentArray:[ @request.requestURLString ])
        
        @handler.requestPredicate = @predicate
      end
      
      describe "and evaluates to YES" do
        
        before(:each) do
          @predicate.evaluateWithObject(@request).should == true
        end
        
        it "should return YES" do
          @handler.canPerformRequest(@request).should == true
        end
        
      end
      
      describe "and evaluates to NO" do
        
        before(:each) do
          @handler.requestPredicate = NSPredicate.predicateWithValue(false)
        end
        
        it "should return NO" do
          @handler.canPerformRequest(@request).should == false
        end
        
      end
      
      describe "but neither #response nor #error has been set" do
        
        before(:each) do
          @handler.response = nil
        end
        
        it "should return NO" do
          @handler.canPerformRequest(@request).should == false
        end
        
      end
      
    end
    
  end
  
end