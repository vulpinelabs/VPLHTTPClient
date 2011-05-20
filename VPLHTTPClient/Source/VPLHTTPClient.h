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

+ (void)registerResponse:(VPLHTTPResponse *)response
                  forURI:(NSString *)uriString;

// ===== REQUEST HANDLERS ==============================================================================================

- (BOOL)isRequestHandlerRegistered:(NSObject<VPLHTTPRequestHandler> *)handler;

- (void)prependRequestHandler:(NSObject<VPLHTTPRequestHandler> *)handler;
- (void)appendRequestHandler:(NSObject<VPLHTTPRequestHandler> *)handler;

- (void)removeRequestHandler:(NSObject<VPLHTTPRequestHandler> *)handler;

@end
