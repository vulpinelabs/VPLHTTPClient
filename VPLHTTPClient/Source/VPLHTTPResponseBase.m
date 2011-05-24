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

@end
