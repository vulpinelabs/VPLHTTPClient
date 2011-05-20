//
//  VPLHTTPResponse.m
//  TrackerCore
//
//  Created by Christian Niles on 5/13/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import "VPLHTTPResponse.h"

NSString * const VPLHTTPContentTypeHeader = @"Content-Type";

@implementation VPLHTTPResponse

- (id)initWithStatusCode:(NSUInteger)statusCode
                    body:(NSData *)body
             contentType:(NSString *)contentType
{
  self = [self init];
  if (self) {
    
    _statusCode = statusCode;
    _body = [body retain];
    _contentType = [contentType retain];
    
  }
  
  return self;
}

- (void)dealloc
{
  [_body release];
  [_contentType release];
  
  [super dealloc];
}

// ===== STATUS CODE ===================================================================================================
#pragma mark -
#pragma mark Status Code

@synthesize statusCode=_statusCode;

// ===== BODY ==========================================================================================================
#pragma mark -
#pragma mark Body

@synthesize body=_body;

// ===== CONTENT TYPE ==================================================================================================
#pragma mark -
#pragma mark Content-Type

@synthesize contentType=_contentType;

// ===== RESPONSE HELPERS ==============================================================================================
#pragma mark -
#pragma mark Response Helpers

+ (VPLHTTPResponse *)response
{
  return [[[self alloc] initWithStatusCode:200
                                      body:[NSData data]
                               contentType:@"text/plain"] autorelease];
}

+ (VPLHTTPResponse *)responseWithXML:(NSString *)xmlString
{
  VPLHTTPResponse * response = [[self alloc] initWithStatusCode:200
                                                          body:[xmlString dataUsingEncoding:NSUTF8StringEncoding]
                                                   contentType:@"application/xml; charset=utf8"];
  
  return [response autorelease];
}

@end
