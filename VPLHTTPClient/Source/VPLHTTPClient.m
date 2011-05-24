//
//  VPLHTTPClient.m
//  TrackerCore
//
//  Created by Christian Niles on 5/13/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import "VPLHTTPClient.h"
#import "VPLHTTPRequest.h"
#import "VPLHTTPGenericRequestHandler.h"

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
    
  }
  
  return self;
}

- (void)dealloc
{
  [super dealloc];
}

// ===== REQUEST HANDLER REGISTRY ======================================================================================
#pragma mark -
#pragma Request Handler Registry

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
  [handler setRequestPredicate:[NSPredicate predicateWithFormat:@"URLString = %@", uriString]];
  
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
  
  return NO;
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
    
    NSError * error = [NSError errorWithDomain:VPLHTTPErrorDomain
                                          code:VPLHTTPRequestNotPerformedError
                                      userInfo:[NSDictionary dictionaryWithObject:request forKey:@"request"]];
    errorCallback(error);
    
  } else {
    
    [NSException raise:@"VPLHTTPClientNetworkRequestsDisabledError"
                format:@"Network requests are disabled: %@", [request requestURLString]];
    
  }
}

@end
