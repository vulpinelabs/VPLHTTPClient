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
  
} VPLHTTPErrorCode;
