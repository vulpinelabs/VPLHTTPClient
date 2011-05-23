//
//  VPLHTTPClient.h
//  TrackerCore
//
//  Created by Christian Niles on 5/13/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPRequestHandlerBase.h"

/*!
 *  Responsible for coordinating all HTTP traffic.
 */
@interface VPLHTTPClient : VPLHTTPRequestHandlerBase {
@private
  NSMutableArray * _requestHandlers;
}

/*!
 *  Determines if network requests are enabled or not.
 */
+ (BOOL)networkRequestsEnabled;

/*!
 *  Enables and disables handling of requests externally. Any requests not handled by an in-process handler will cause
 *  an exception to be raised.
 */
+ (void)setNetworkRequestsEnabled:(BOOL)networkRequestsEnabled;

/*!
 *  Registers a global handler for the given URI string that returns the given response. With
 *  #setNetworkRequestsEnabled:, this allows HTTP requests to be mocked during testing.
 */
+ (void)registerResponse:(VPLHTTPResponse *)response
                  forURI:(NSString *)uriString;

/*!
 *  Resets all global state, re-enabling network requests and removing all registered URI handlers.
 */
+ (void)reset;

// ===== REQUEST HANDLERS ==============================================================================================

- (BOOL)isRequestHandlerRegistered:(NSObject<VPLHTTPRequestHandler> *)handler;

- (void)prependRequestHandler:(NSObject<VPLHTTPRequestHandler> *)handler;
- (void)appendRequestHandler:(NSObject<VPLHTTPRequestHandler> *)handler;

- (void)removeRequestHandler:(NSObject<VPLHTTPRequestHandler> *)handler;

@end
