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

+ (NSString *)defaultResponseStatusMessageForCode:(NSUInteger)responseCode
{
  switch (responseCode) {
    case 100:
      return @"Continue";
    case 101:
      return @"Switching Protocols";
    case 102:
      return @"Processing";
    case 122:
      return @"Request-URI too long";
    
    case 200:
      return @"OK";
    case 201:
      return @"Created";
    case 202:
      return @"Accepted";
    case 203:
      return @"Non-Authoritative Information";
    case 204:
      return @"No Content";
    case 205:
      return @"Reset Content";
    case 206:
      return @"Partial Content";
    case 207:
      return @"Multi-Status";
    case 226:
      return @"IM Used";
      
    case 300:
      return @"Multiple Choices";
    case 301:
      return @"Moved Permanently";
    case 302:
      return @"Found";
    case 303:
      return @"See Other";
    case 304:
      return @"Not Modified";
    case 305:
      return @"Use Proxy";
    case 306:
      return @"Switch Proxy";
    case 307:
      return @"Temporary Redirect";
    
    case 400:
      return @"Bad Request";
    case 401:
      return @"Unauthorized";
    case 402:
      return @"Payment Required";
    case 403:
      return @"Forbidden";
    case 404:
      return @"Not Found";
    case 405:
      return @"Method Not Allowed";
    case 406:
      return @"Not Acceptable";
    case 407:
      return @"Proxy Authentication Required";
    case 408:
      return @"Request Timeout";
    case 409:
      return @"Conflict";
    case 410:
      return @"Gone";
    case 411:
      return @"Length Required";
    case 412:
      return @"Precondition Failed";
    case 413:
      return @"Request Entity Too Large";
    case 414:
      return @"Request-URI Too Long";
    case 415:
      return @"Unsupported Media Type";
    case 416:
      return @"Requested Range Not Satisfiable";
    case 417:
      return @"Expectation Failed";
    case 418:
      return @"I'm a teapot";
    case 422:
      return @"Unprocessable Entity";
    case 423:
      return @"Locked";
    case 424:
      return @"Failed Dependency";
    case 425:
      return @"Unordered Collection";
    case 426:
      return @"Upgrade Required";
    case 444:
      return @"No Response";
    case 449:
      return @"Retry With";
    case 450:
      return @"Blocked by Windows Parental Controls";
    case 499:
      return @"Client Closed Request";
      
    case 500:
      return @"Internal Server Error";
    case 501:
      return @"Not Implemented";
    case 502:
      return @"Bad Gateway";
    case 503:
      return @"Service Unavailable";
    case 504:
      return @"Gateway Timeout";
    case 505:
      return @"HTTP Version Not Supported";
    case 506:
      return @"Variant Also Negotiates";
    case 507:
      return @"Insufficient Storage";
    case 509:
      return @"Bandwidth Limit Exceeded";
    case 510:
      return @"Not Extended";
      
    default:
      return nil;
  }
}

- (NSString *)responseStatusMessage
{
  return [[self class] defaultResponseStatusMessageForCode:self.responseCode];
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
