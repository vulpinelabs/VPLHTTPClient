//
//  VPLHTTPGenericRequest.m
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/23/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import "VPLHTTPGenericRequest.h"

@implementation VPLHTTPGenericRequest

- (id)initWithURLString:(NSString *)URLString
{
  return [self initWithURLString:URLString method:@"GET"];
}

- (id)initWithURLString:(NSString *)URLString
                 method:(NSString *)requestMethod
{
  self = [self init];
  if (self != nil) {
    
    _requestURLString = [URLString retain];
    _requestMethod = (requestMethod ? [requestMethod retain] : [@"GET" retain]);
    _requestTimeout = 60.0;
    _validatesSSLCertificates = YES;
    
  }
  return self;
}

- (void)dealloc
{
  [_requestURLString release];
  [_requestMethod release];
  [_requestHeaders release];
  [_username release];
  [_password release];
  [_requestBody release];
  
  [super dealloc];
}

// ===== REQUEST METHOD ================================================================================================
#pragma mark -
#pragma mark Request Method

@synthesize requestMethod=_requestMethod;

// ===== URL STRING ====================================================================================================
#pragma mark -
#pragma mark URL String

@synthesize requestURLString=_requestURLString;

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

// ===== REQUEST BODY ==================================================================================================
#pragma mark -
#pragma mark Request Body

@synthesize requestBody=_requestBody;

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

// ===== REQUEST TIMEOUT ===============================================================================================
#pragma mark -
#pragma mark Request Timeout

@synthesize requestTimeout = _requestTimeout;

// ===== VALIDATES SSL CERTIFICATES ====================================================================================
#pragma mark -
#pragma mark Validates SSL Certificates

@synthesize validatesSSLCertificates = _validatesSSLCertificates;

@end
