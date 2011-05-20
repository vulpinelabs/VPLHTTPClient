//
//  VPLHTTPGenericRequestHandler.m
//  TrackerCore
//
//  Created by Christian Niles on 5/15/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import "VPLHTTPGenericRequestHandler.h"
#import "VPLHTTPRequest.h"
#import "VPLHTTPResponse.h"

@implementation VPLHTTPGenericRequestHandler

- (id)initWithResponse:(VPLHTTPResponse *)response
{
  self = [self init];
  if (self) {
    _response = [response retain];
  }
  return self;
}

- (id)initWithError:(NSError *)error
{
  self = [self init];
  if (self) {
    _error = [error retain];
  }
  return self;
}

- (void)dealloc
{
  [_requestPredicate release];
  [_response release];
  [_error release];
  [super dealloc];
}

// ===== REQUEST PREDICATE =============================================================================================
#pragma mark -
#pragma mark Request Predicate

@synthesize requestPredicate=_requestPredicate;

// ===== RESPONSE ======================================================================================================
#pragma mark -
#pragma mark Response

@synthesize response=_response;

// ===== ERROR =========================================================================================================
#pragma mark -
#pragma mark Error

@synthesize error=_error;

// ===== TKREQUESTHANLDER METHODS ======================================================================================
#pragma mark -
#pragma mark TKRequestHandler Methods

- (BOOL)canPerformRequest:(VPLHTTPRequest *)request
{
  if (self.response != nil || self.error != nil) {
    
    return self.requestPredicate == nil || [self.requestPredicate evaluateWithObject:request];
    
  } else {
    
    return NO;
    
  }
}

- (void)performRequest:(VPLHTTPRequest *)request
               success:(VPLHTTPSuccessCallback)successCallback
                 error:(VPLHTTPErrorCallback)errorCallback
{
  if (self.error != nil) {
    
    errorCallback(self.error);
  
  } else if (self.response != nil) {
    
    successCallback(self.response);
  
  } else {
    
    [super performRequest:request
                  success:successCallback
                    error:errorCallback];
    
  }
}

@end
