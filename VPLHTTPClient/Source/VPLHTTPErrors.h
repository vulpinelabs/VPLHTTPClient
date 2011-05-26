//
//  VPLHTTPErrors.h
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//! The NSError domain provided to VPLHTTPErrorCallback blocks
extern NSString * const VPLHTTPErrorDomain;

//! The NSError codes provided to VPLHTTPErrorCallback blocks
typedef enum _VPLHTTPErrorCode {
  
  //! When a VPLHTTPRequest was not performed, because no VPLHTTPRequestHandler implementations support it
  VPLHTTPRequestNotPerformedError = 1,
  
  //! When performing a VPLHTTPRequest was not performed due to local security constraints or other rules.
  VPLHTTPRequestNotAllowedError,
  
  //! A VPLHTTPRequest was cancelled.
  VPLHTTPRequestCancelledError,
  
  //! A connection to the server couldn't be made, either because the server is down, or no internet connection exists.
  VPLHTTPRequestConnectionFailedError,
  
  //! A connection was established, but the server took too long to respond.
  VPLHTTPRequestTimedOutError,
  
  //! Authentication is required, or the provided credentials weren't accepted.
  VPLHTTPRequestAccessDeniedError,
  
  //! The server sent too many redirects in a row.
  VPLHTTPRequestTooMuchRedirectionError,
  
  //! An internal programming error ocurred, like a memory error or assertion failure.
  VPLHTTPRequestInternalError
  
} VPLHTTPErrorCode;
