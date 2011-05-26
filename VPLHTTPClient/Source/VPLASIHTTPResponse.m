//
//  VPLASIHTTPResponse.m
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VPLASIHTTPResponse.h"
#import "ASIHTTPRequest.h"
#import "VPLHTTPErrors.h"

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

+ (NSError *)errorWithASIError:(NSError *)asiHttpError
{
  if ([[asiHttpError domain] isEqualToString:NetworkRequestErrorDomain]) {
    
    // an A
    VPLHTTPErrorCode errorCode = VPLHTTPRequestInternalError;
    
    switch ([asiHttpError code]) {
      case ASIConnectionFailureErrorType:
        errorCode = VPLHTTPRequestConnectionFailedError;
        break;
        
      case ASIRequestTimedOutErrorType:
        errorCode = VPLHTTPRequestTimedOutError;
        break;
        
      case ASIAuthenticationErrorType:
        errorCode = VPLHTTPRequestAccessDeniedError;
        break;
        
      case ASIRequestCancelledErrorType:
        errorCode = VPLHTTPRequestCancelledError;
        break;
        
      case ASITooMuchRedirectionErrorType:
        errorCode = VPLHTTPRequestTooMuchRedirectionError;
        break;
        
      case ASIUnableToCreateRequestErrorType:
      case ASIInternalErrorWhileBuildingRequestType:
      case ASIInternalErrorWhileApplyingCredentialsType:
      case ASIFileManagementError:
      case ASIUnhandledExceptionError:
      case ASICompressionError:
        break;
        
    }    
    
    return [NSError errorWithDomain:VPLHTTPErrorDomain
                               code:errorCode
                           userInfo:[NSDictionary dictionaryWithObject:asiHttpError
                                                                forKey:NSUnderlyingErrorKey]];
    
  } else {
    
    // a lower-level error is being returned...
    return asiHttpError;
    
  }
}

// ===== RESPONSE STATUS CODE ==========================================================================================
#pragma mark -
#pragma mark Status Code

- (NSUInteger)responseCode
{
  return [[self _httpRequest] responseStatusCode];
}

- (NSString *)responseStatusMessage
{
  NSString * statusMessage = [[self _httpRequest] responseStatusMessage];
  if (statusMessage == nil) {
    return [super responseStatusMessage];
  } else {
    return statusMessage;
  }
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
