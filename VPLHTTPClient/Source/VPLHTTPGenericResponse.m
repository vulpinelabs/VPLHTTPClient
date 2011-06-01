//
//  VPLHTTPGenericResponse.m
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/23/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import "VPLHTTPGenericResponse.h"

NSString * const VPLHTTPContentTypeHeader = @"Content-Type";

@implementation VPLHTTPGenericResponse

- (id)initWithResponseCode:(NSUInteger)statusCode
                      body:(NSData *)body
               contentType:(NSString *)contentType
{
  self = [self init];
  if (self) {
    
    _responseCode = statusCode;
    _responseBody = [body retain];
    _responseContentType = [contentType retain];
    
  }
  
  return self;
}

- (void)dealloc
{
  [_responseBody release];
  [_responseContentType release];
  
  [super dealloc];
}

// ===== STATUS CODE ===================================================================================================
#pragma mark -
#pragma mark Status Code

- (NSUInteger)responseCode
{
  return _responseCode;
}

// ===== BODY ==========================================================================================================
#pragma mark -
#pragma mark Body

- (NSData *)responseBody
{
  return _responseBody;
}

// ===== CONTENT TYPE ==================================================================================================
#pragma mark -
#pragma mark Content-Type

- (NSString *)responseContentType
{
  return _responseContentType;
}

// ===== RESPONSE HELPERS ==============================================================================================
#pragma mark -
#pragma mark Response Helpers

+ (NSObject <VPLHTTPResponse> *)response
{
  return [[[self alloc] initWithResponseCode:200
                                        body:[NSData data]
                                 contentType:@"text/plain"] autorelease];
}

+ (NSObject <VPLHTTPResponse> *)responseWithXML:(NSString *)xmlString
{
  NSObject <VPLHTTPResponse> * response = [[self alloc] initWithResponseCode:200
                                                                        body:[xmlString dataUsingEncoding:NSUTF8StringEncoding]
                                                                 contentType:@"application/xml; charset=utf8"];
  
  return [response autorelease];
}

+ (NSObject <VPLHTTPResponse> *)notFoundResponse
{
  return [[[self alloc] initWithResponseCode:404
                                        body:[NSData data]
                                 contentType:@"text/plain"] autorelease];
}

@end
