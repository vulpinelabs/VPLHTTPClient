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
    _requestHandlers = [[NSMutableArray alloc] initWithCapacity:8];
  }
  
  return self;
}

- (void)dealloc
{
  [_requestHandlers release];
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

+ (void)registerResponse:(VPLHTTPResponse *)response
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

// ===== REQUEST HANDLERS ==============================================================================================
#pragma mark -
#pragma mark Request Handlers

- (BOOL)isRequestHandlerRegistered:(NSObject<VPLHTTPRequestHandler> *)handler
{
  return [_requestHandlers containsObject:handler];
}

- (void)prependRequestHandler:(NSObject<VPLHTTPRequestHandler> *)handler
{
  if ([self isRequestHandlerRegistered:handler]) [_requestHandlers removeObject:handler];
  
  [_requestHandlers insertObject:handler
                         atIndex:0];
}

- (void)appendRequestHandler:(NSObject<VPLHTTPRequestHandler> *)handler
{
  if ([self isRequestHandlerRegistered:handler]) [_requestHandlers removeObject:handler];
  [_requestHandlers addObject:handler];
}

- (void)removeRequestHandler:(NSObject<VPLHTTPRequestHandler> *)handler
{
  [_requestHandlers removeObject:handler];
}

// ===== REQUEST DISPATCH ==============================================================================================
#pragma mark -
#pragma mark Request Dispatch

- (BOOL)canPerformRequest:(VPLHTTPRequest *)request
{
  for (NSObject<VPLHTTPRequestHandler> * handler in _requestHandlers) {
    
    if ([handler canPerformRequest:request]) return YES;
    
  }
  
  NSMutableArray * globalHandlers = nil;
  @synchronized ([self class]) {
    globalHandlers = [VPLHTTPClientGlobalHandlers copy];
  }
  
  for (NSObject<VPLHTTPRequestHandler> * handler in _requestHandlers) {
    if ([handler canPerformRequest:request]) return YES;
  }
  
  [globalHandlers release];
  
  return [super canPerformRequest:request];
}

- (void)performRequest:(VPLHTTPRequest *)request
               success:(VPLHTTPSuccessCallback)successCallback
                 error:(VPLHTTPErrorCallback)errorCallback
{
  for (NSObject<VPLHTTPRequestHandler> * handler in _requestHandlers) {
    if ([handler canPerformRequest:request]) {
      [handler performRequest:request
                      success:successCallback
                        error:errorCallback];
      return;
    }
  }
  
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
    
    [super performRequest:request
                  success:successCallback
                    error:errorCallback];
    
  } else {
    
    [NSException raise:@"VPLHTTPClientNetworkRequestsDisabledError"
                format:@"Network requests are disabled: %@", [request URLString]];
    
  }
}

@end
