//
//  VPLASIHTTPRequest.m
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VPLASIHTTPRequest.h"
#import "ASIHTTPRequest.h"

@implementation VPLASIHTTPRequest

- (id)initWithURL:(NSURL *)requestURL
{
  self = [self init];
  if (self) {
    _asiHttpRequest = [[ASIHTTPRequest alloc] initWithURL:requestURL];
  }
  
  return self;
}

- (id)initWithURLString:(NSString *)requestURLString
{
  return [self initWithURL:[NSURL URLWithString:requestURLString]];
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
  return [self _httpRequest].requestHeaders;
}

- (void)addRequestHeader:(NSString *)headerName
                   value:(NSString *)headerValue
{
  [[self _httpRequest] addRequestHeader:headerName
                                  value:headerValue];
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

// ===== RESPONSE STATUS CODE ==========================================================================================
#pragma mark -
#pragma mark Status Code

- (NSUInteger)responseCode
{
  return [[self _httpRequest] responseStatusCode];
}

// ===== RESPONSE BODY =================================================================================================
#pragma mark -
#pragma mark Response Body

- (NSData *)responseBody
{
  return [[self _httpRequest] responseData];
}

// ===== RESPONSE CONTENT TYPE =========================================================================================
#pragma mark -
#pragma mark Response Content Type

- (NSString *)responseContentType
{
  return [[[self _httpRequest] responseHeaders] objectForKey:@"Content-Type"];
}

@end
