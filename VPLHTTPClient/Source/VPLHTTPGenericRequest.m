//
//  VPLHTTPGenericRequest.m
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VPLHTTPGenericRequest.h"

@implementation VPLHTTPGenericRequest

- (id)initWithURLString:(NSString *)URLString
{
  self = [self init];
  if (self != nil) {
    
    _URLString = [URLString retain];
    _requestMethod = [@"GET" retain];
    
  }
  return self;
}

- (void)dealloc
{
  [_URLString release];
  [_requestMethod release];
  [_requestHeaders release];
  [_username release];
  [_password release];
  
  [super dealloc];
}

// ===== REQUEST METHOD ================================================================================================
#pragma mark -
#pragma mark Request Method

@synthesize requestMethod=_requestMethod;

// ===== URL STRING ====================================================================================================
#pragma mark -
#pragma mark URL String

@synthesize requestURLString=_URLString;

- (NSURL *)requestURL
{
  if (self.requestURLString != nil) {
    return [NSURL URLWithString:self.requestURLString];
  } else {
    return nil;
  }
}

// ===== HEADERS =======================================================================================================
#pragma mark -
#pragma mark Headers

- (NSDictionary *)requestHeaders
{
  return _requestHeaders;
}

- (void)addRequestHeader:(NSString *)headerName
                   value:(NSString *)headerValue
{
  [_requestHeaders setObject:headerValue
                      forKey:headerName];
}

// ===== AUTHENTICATION ================================================================================================
#pragma mark -
#pragma mark Authentication

@synthesize username=_username;

@synthesize password=_password;

- (void)setUsername:(NSString *)username
           password:(NSString *)password
{
  if (username != _username) {
    [_username release];
    _username = [username retain];
  }
  
  if (password != _password) {
    [_password release];
    _password = [password retain];
  }
}

@end
