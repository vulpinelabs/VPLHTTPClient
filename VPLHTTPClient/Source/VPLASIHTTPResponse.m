//
//  VPLASIHTTPResponse.m
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VPLASIHTTPResponse.h"
#import "ASIHTTPRequest.h"

@implementation VPLASIHTTPResponse

+ (VPLASIHTTPResponse *)responseWithRequest:(ASIHTTPRequest *)request
{
  return [[[self alloc] initWithRequest:request] autorelease];
}

- (id)initWithRequest:(ASIHTTPRequest *)request
{
  self = [super init];
  if (self) {
    _asiHttpRequest = [request retain];
  }
  
  return self;
}

- (void)dealloc
{
  [_asiHttpRequest release];
  [super dealloc];
}

// ===== HTTP REQUEST ==================================================================================================
#pragma mark -
#pragma mark ASIHTTPRequest

- (ASIHTTPRequest *)_httpRequest
{
  return _asiHttpRequest;
}

// ===== ERROR =========================================================================================================
#pragma mark -
#pragma mark Error Handling

+ (NSError *)errorWithASIError:(ASIHTTPRequest *)requestInError
{
  // For now don't convert the error, but eventually it should be mapped to a common error domain
  return [requestInError error];
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
