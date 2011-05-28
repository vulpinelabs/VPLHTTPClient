//
//  VPLHTTPClient.m
//  TrackerCore
//
//  Created by Christian Niles on 5/13/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import "VPLHTTPClient.h"
#import "VPLHTTPErrors.h"
#import "VPLHTTPRequest.h"
#import "VPLHTTPGenericRequestHandler.h"
#import "VPLASIHTTPRequest.h"
#import "VPLASIHTTPResponse.h"
#import "ASIHTTPRequest.h"

static BOOL TKNetworkRequestsEnabled = YES;
static NSMutableArray * VPLHTTPClientGlobalHandlers = nil;

@implementation VPLHTTPClient

+ (void)initialize
{
  VPLHTTPClientGlobalHandlers = [[NSMutableArray alloc] initWithCapacity:8];
}

- (id)init
{
  self = [super init];
  if (self) {
    _requestQueue = [[NSOperationQueue alloc] init];
    [_requestQueue setMaxConcurrentOperationCount:1];
  }
  
  return self;
}

- (void)dealloc
{
  [_name release];
  [_requestQueue release];
  [super dealloc];
}

// ===== LOG REQUESTS TOGGLE ===========================================================================================
#pragma mark -
#pragma Request Logging

@synthesize logRequests=_logRequests;

// ===== REQUEST HANDLER REGISTRY ======================================================================================
#pragma mark -
#pragma mark Request Handler Registry

+ (BOOL)networkRequestsEnabled
{
  @synchronized (self) {
    return TKNetworkRequestsEnabled;
  }
}

+ (void)setNetworkRequestsEnabled:(BOOL)networkRequestsEnabled
{
  @synchronized (self) {
    TKNetworkRequestsEnabled = networkRequestsEnabled;
  }
}

+ (void)registerResponse:(NSObject <VPLHTTPResponse> *)response
                  forURI:(NSString *)uriString
{
  VPLHTTPGenericRequestHandler * handler = [[VPLHTTPGenericRequestHandler alloc] initWithResponse:response];
  [handler setRequestPredicate:[NSPredicate predicateWithFormat:@"requestURLString = %@", uriString]];
  
  @synchronized (self) {
    [VPLHTTPClientGlobalHandlers addObject:handler];
  }
  [handler release];
}

+ (void)reset
{
  @synchronized (self) {
    TKNetworkRequestsEnabled = YES;
    [VPLHTTPClientGlobalHandlers removeAllObjects];
  }
}

// ===== NAME ==========================================================================================================
#pragma mark -
#pragma mark Name

@synthesize name=_name;

- (void)setName:(NSString *)name
{
  if (name != _name) {
    [_name release];
    _name = [name retain];
    [_requestQueue setName:name];
  }
}

// ===== REQUESTS ======================================================================================================
#pragma mark -
#pragma mark Requests

- (NSObject <VPLHTTPRequest> *)GETRequestWithURLString:(NSString *)url
{
  return [[[VPLASIHTTPRequest alloc] initWithURLString:url] autorelease];
}

// ===== REQUEST DISPATCH ==============================================================================================
#pragma mark -
#pragma mark Request Dispatch

- (BOOL)canPerformRequest:(NSObject <VPLHTTPRequest> *)request
{
  NSMutableArray * globalHandlers = nil;
  @synchronized ([self class]) {
    globalHandlers = [VPLHTTPClientGlobalHandlers copy];
  }
  
  for (NSObject<VPLHTTPRequestHandler> * handler in globalHandlers) {
    if ([handler canPerformRequest:request]) return YES;
  }
  
  [globalHandlers release];
  
  return [request isKindOfClass:[VPLASIHTTPRequest class]];
}

- (void)performRequest:(NSObject <VPLHTTPRequest> *)request
               success:(VPLHTTPSuccessCallback)successCallback
                 error:(VPLHTTPErrorCallback)errorCallback
{
  NSMutableArray * globalHandlers = nil;
  @synchronized ([self class]) {
    globalHandlers = [VPLHTTPClientGlobalHandlers copy];
  }
  
  [globalHandlers autorelease];
  
  for (NSObject<VPLHTTPRequestHandler> * handler in globalHandlers) {
    if ([handler canPerformRequest:request]) {
      [handler performRequest:request
                      success:successCallback
                        error:errorCallback];
      return;
    }
  }
  
  
  if ([[self class] networkRequestsEnabled]) {
    
    if ([request isKindOfClass:[VPLASIHTTPRequest class]]) {
      
      successCallback = [[successCallback copy] autorelease];
      errorCallback = [[errorCallback copy] autorelease];
      
      __block ASIHTTPRequest * asiRequest = [(VPLASIHTTPRequest *)request _httpRequest];
      if (successCallback) {
        [asiRequest setCompletionBlock:^(void) {
          
          successCallback([VPLASIHTTPResponse responseWithRequest:asiRequest]);
          
        }];
      }
      
      if (errorCallback) {
        [asiRequest setFailedBlock:^(void) {
          
          errorCallback([VPLASIHTTPResponse errorWithASIError:asiRequest.error]);
          
        }];
      }
      
      // add the request
      if (_logRequests) {
        NSLog(@"Dispatching %@ request for: %@", request.requestMethod, request.requestURLString);
      }
      [_requestQueue addOperation:asiRequest];
      
    } else {
      
      if (errorCallback) {
        NSError * error = [NSError errorWithDomain:VPLHTTPErrorDomain
                                              code:VPLHTTPRequestNotPerformedError
                                          userInfo:[NSDictionary dictionaryWithObject:request forKey:@"request"]];
        errorCallback(error);
      }
      
    }
    
  } else {
    
    [NSException raise:@"VPLHTTPClientNetworkRequestsDisabledError"
                format:@"Network requests are disabled: %@", [request requestURLString]];
    
  }
}

@end
