//
//  VPLASIHTTPRequest.m
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/23/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import "VPLASIHTTPRequest.h"
#import "ASIHTTPRequest.h"

@implementation VPLASIHTTPRequest

- (id)initWithURL:(NSURL *)requestURL
{
  return [self initWithURL:requestURL method:@"GET"];
}

- (id)initWithURL:(NSURL *)requestURL
           method:(NSString *)requestMethod
{
  self = [self init];
  
  if (self) {
    _asiHttpRequest = [[ASIHTTPRequest alloc] initWithURL:requestURL];
    [_asiHttpRequest setUseKeychainPersistence:NO];
    [_asiHttpRequest setUseSessionPersistence:NO];
    [_asiHttpRequest setRequestMethod:requestMethod];
  }
  
  return self;
}

- (id)initWithURLString:(NSString *)requestURLString
{
  return [self initWithURL:[NSURL URLWithString:requestURLString]];
}

- (id)initWithURLString:(NSString *)requestURLString
                 method:(NSString *)requestMethod
{
  return [self initWithURL:[NSURL URLWithString:requestURLString]
                    method:requestMethod];
}

- (void)dealloc
{
  [_asiHttpRequest release];
  [super dealloc];
}

- (ASIHTTPRequest *)_httpRequest
{
  return _asiHttpRequest;
}

// ===== REQUEST METHOD ================================================================================================
#pragma mark -
#pragma mark Request Method

- (NSString *)requestMethod
{
  return [[self _httpRequest] requestMethod];
}

// ===== URL ===========================================================================================================
#pragma mark -
#pragma mark URL

- (NSString *)requestURLString
{
  return [[self _httpRequest].url absoluteString];
}

- (NSURL *)requestURL
{
  return [self _httpRequest].url;
}

// ===== HEADERS =======================================================================================================
#pragma mark -
#pragma mark Headers

- (NSDictionary *)requestHeaders
{
  NSDictionary * requestHeaders = [self _httpRequest].requestHeaders;
  if (requestHeaders == nil) {
    
    requestHeaders = [NSDictionary dictionary];
    
  }
  return requestHeaders;
}

- (void)addRequestHeader:(NSString *)headerName
                   value:(NSString *)headerValue
{
  [[self _httpRequest] addRequestHeader:headerName
                                  value:headerValue];
}

// ===== REQUEST BODY ==================================================================================================
#pragma mark -
#pragma mark Request Body

- (NSData *)requestBody
{
  return [[self _httpRequest] postBody];
}

- (void)setRequestBody:(NSData *)requestBody
{
  if (requestBody == nil || [requestBody isKindOfClass:[NSMutableData class]]) {
    
    [[self _httpRequest] setPostBody:(NSMutableData *)requestBody];
    
  } else {
    
    [[self _httpRequest] setPostBody:[NSMutableData dataWithData:requestBody]];
    
  }
}

// ===== AUTHENTICATION ================================================================================================
#pragma mark -
#pragma mark Authentication

- (NSString *)username
{
  return [[self _httpRequest] username];
}

- (NSString *)password
{
  return [[self _httpRequest] password];
}

- (void)setUsername:(NSString *)username
           password:(NSString *)password
{
  [[self _httpRequest] setUsername:username];
  [[self _httpRequest] setPassword:password];
}

// ===== REQUEST TIMEOUT ===============================================================================================
#pragma mark -
#pragma mark Request Timeout

- (NSTimeInterval)requestTimeout
{
  return [[self _httpRequest] timeOutSeconds];
}

- (void)setRequestTimeout:(NSTimeInterval)requestTimeout
{
  [[self _httpRequest] setTimeOutSeconds:requestTimeout];
}

@end
