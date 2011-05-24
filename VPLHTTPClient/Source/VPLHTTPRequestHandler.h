//
//  VPLHTTPRequestHandler.h
//  TrackerCore
//
//  Created by Christian Niles on 5/15/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPRequest.h"
#import "VPLHTTPResponse.h"

//! The NSError domain provided to VPLHTTPErrorCallback blocks
#define VPLHTTPErrorDomain @"VPLHTTPErrorDomain"

//! The NSError codes provided to VPLHTTPErrorCallback blocks
typedef enum _VPLHTTPErrorCode {
  
  //! When a VPLHTTPRequest was not performed, because no VPLHTTPRequestHandler implementations support it
  VPLHTTPRequestNotPerformedError = 1,
  
  //! When performing a VPLHTTPRequest was not performed due to local security constraints or other rules.
  VPLHTTPRequestNotAllowedError,
  
} VPLHTTPErrorCode;

typedef void(^VPLHTTPSuccessCallback)(NSObject <VPLHTTPResponse> *);
typedef void(^VPLHTTPErrorCallback)(NSError *);

/*!
 *  Generic API for performing an HTTP request.
 */
@protocol VPLHTTPRequestHandler <NSObject>

/*!
 *  Determines whether the implementation can perform the given request or not.
 */
- (BOOL)canPerformRequest:(NSObject <VPLHTTPRequest> *)request;

/*!
 *  Performs the given request asynchronously and invokes the successCallback when the request is successful, or the
 *  errorCallback when the request could not be performed, such as when a network connection is unavailable. If the 
 *  implementation encounters an error before dispatching the request it may invoke the error callback immediately.
 *
 *  If the handler is not capable of performing the request, it should invoke errorCallback immediately, providing an
 *  NSError within the VPLHTTPErrorDomain, and an error code of VPLHTTPRequestNotPerformedError. The #canPerformRequest:
 *  method allows callers to detect this case before invoking this method.
 */
- (void)performRequest:(NSObject <VPLHTTPRequest> *)request
               success:(VPLHTTPSuccessCallback)successCallback
                 error:(VPLHTTPErrorCallback)errorCallback;

@end
