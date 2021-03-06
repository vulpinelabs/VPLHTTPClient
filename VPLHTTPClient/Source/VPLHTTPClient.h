//
//  VPLHTTPClient.h
//  TrackerCore
//
//  Created by Christian Niles on 5/13/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPRequestHandler.h"

/*!
 *  Responsible for coordinating all HTTP traffic.
 */
@interface VPLHTTPClient : NSObject <VPLHTTPRequestHandler> {
@private
  NSString * _name;
  NSOperationQueue * _requestQueue;
  
  BOOL _logRequests;
  NSTimeInterval _defaultRequestTimeout;
}

// ===== LOG REQUESTS TOGGLE ===========================================================================================

@property (nonatomic,assign) BOOL logRequests;

// ===== NETWORK REQUEST TOGGLE ========================================================================================

/*!
 *  Determines if network requests are enabled or not.
 */
+ (BOOL)networkRequestsEnabled;

/*!
 *  Enables and disables handling of requests externally. Any requests not handled by an in-process handler will cause
 *  an exception to be raised.
 */
+ (void)setNetworkRequestsEnabled:(BOOL)networkRequestsEnabled;

// ===== GLOBAL REQUEST HANDLERS =======================================================================================

+ (void)registerGlobalHandler:(id<VPLHTTPRequestHandler>)globalHandler;
+ (void)unregisterGlobalHandler:(id<VPLHTTPRequestHandler>)globalHandler;

/*!
 *  Registers a global handler for the given URI string that returns the given response. With
 *  #setNetworkRequestsEnabled:, this allows HTTP requests to be mocked during testing.
 */
+ (id<VPLHTTPRequestHandler>)registerResponse:(NSObject <VPLHTTPResponse> *)response
                                       forURI:(NSString *)uriString;

+ (id<VPLHTTPRequestHandler>)registerResponse:(NSObject <VPLHTTPResponse> *)response
                                       forURI:(NSString *)uriString
                                       method:(NSString *)requestMethod;

/*!
 *  Resets all global state, re-enabling network requests and removing all registered URI handlers.
 */
+ (void)reset;

// ===== NAME ==========================================================================================================

@property (nonatomic, retain) NSString * name;

// ===== DEFAULT TIMEOUT ===============================================================================================

@property (nonatomic, assign) NSTimeInterval defaultRequestTimeout;

// ===== REQUESTS ======================================================================================================

- (NSObject <VPLHTTPRequest> *)prepareGETRequestForURLString:(NSString *)url;

- (NSObject <VPLHTTPRequest> *)prepareRequestForURLString:(NSString *)url
                                               withMethod:(NSString *)requestMethod;

// ===== CANCEL ========================================================================================================

- (void)cancelPendingRequests;

@end
