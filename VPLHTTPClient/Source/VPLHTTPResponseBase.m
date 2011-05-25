//
//  VPLHTTPResponseBase.m
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VPLHTTPResponseBase.h"
#import "ASIHTTPRequest.h"

@implementation VPLHTTPResponseBase

// ===== RESPONSE CODE =================================================================================================
#pragma mark -
#pragma mark Response Code

- (NSUInteger)responseCode
{
  [NSException raise:@"NotImplementedError"
              format:@"VPLHTTPResponseBase#responseCode is abstract and should be overridden"];
  return 0;
}

// ===== CONTENT TYPE ==================================================================================================
#pragma mark -
#pragma mark Content Type

+ (NSString *)extractMimeTypeFromContentType:(NSString *)contentType
{
  NSString * mimeType = nil;
  NSStringEncoding stringEncoding = 0;
  
  [ASIHTTPRequest parseMimeType:&mimeType
            andResponseEncoding:&stringEncoding
                fromContentType:contentType];
  
  return mimeType;
}

- (NSString *)responseContentType
{
  [NSException raise:@"NotImplementedError"
              format:@"VPLHTTPResponseBase#responseContentType is abstract and should be overridden"];
  return nil;
}

- (NSStringEncoding)responseEncoding
{
  NSString * mimeType = nil;
  NSStringEncoding stringEncoding = 0;
  
  [ASIHTTPRequest parseMimeType:&mimeType
            andResponseEncoding:&stringEncoding
                fromContentType:[self responseContentType]];
  
  if (stringEncoding == 0) {
    stringEncoding = NSISOLatin1StringEncoding;
  }
  
  return stringEncoding;
}

// ----- XML -----------------------------------------------------------------------------------------------------------
#pragma mark XML

+ (BOOL)isXMLContentType:(NSString *)contentType
{
  NSString * mimeType = [self extractMimeTypeFromContentType:contentType];
  if (mimeType && 
      ([mimeType hasSuffix:@"/xml"] || [mimeType hasSuffix:@"+xml"])) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)isXML
{
  return [[self class] isXMLContentType:[self responseContentType]];
}

// ----- HTML ----------------------------------------------------------------------------------------------------------
#pragma mark HTML

+ (BOOL)isHTMLContentType:(NSString *)contentType
{
  NSString * mimeType = [self extractMimeTypeFromContentType:contentType];
  if (mimeType && 
      ([mimeType isEqualToString:@"text/html"] ||
       [mimeType isEqualToString:@"application/html"] ||
       [mimeType isEqualToString:@"application/xhtml"] ||
       [mimeType isEqualToString:@"application/xhtml+xml"])) {
    
    return YES;
    
  } else {
 
    return NO;

  }
}

- (BOOL)isHTML
{
  return [[self class] isHTMLContentType:[self responseContentType]];
}

// ----- JSON ----------------------------------------------------------------------------------------------------------
#pragma mark JSON

+ (BOOL)isJSONContentType:(NSString *)contentType
{
  NSString * mimeType = [self extractMimeTypeFromContentType:contentType];
  if (mimeType &&
      ([mimeType isEqualToString:@"application/json"] ||
       [mimeType isEqualToString:@"application/x-json"] ||
       [mimeType isEqualToString:@"text/json"] ||
       [mimeType isEqualToString:@"text/x-json"])) {
    
    return YES;
    
  } else {
    
    return NO;
    
  }
}

- (BOOL)isJSON
{
  return [[self class] isJSONContentType:[self responseContentType]];
}

// ----- PLAIN TEXT ----------------------------------------------------------------------------------------------------
#pragma mark Plain Text

+ (BOOL)isPlainTextContentType:(NSString *)contentType
{
  NSString * mimeType = [self extractMimeTypeFromContentType:contentType];
  if (mimeType && [mimeType isEqualToString:@"text/plain"]) {
    
    return YES;
    
  } else {
    
    return NO;
    
  }
}

- (BOOL)isPlainText
{
  return [[self class] isPlainTextContentType:[self responseContentType]];
}

// ===== RESPONSE BODY =================================================================================================
#pragma mark -
#pragma mark Response Body

- (NSData *)responseBody
{
  [NSException raise:@"NotImplementedError"
              format:@"VPLHTTPResponseBase#responseBody is abstract and should be overridden"];
  return nil;
}

- (NSString *)responseString
{
  NSData * responseBody = [self responseBody];
  if (responseBody != nil) {
    
    return [[[NSString alloc] initWithData:responseBody
                                  encoding:[self responseEncoding]] autorelease];
    
  } else {
    
    return nil;
    
  }
}

@end
