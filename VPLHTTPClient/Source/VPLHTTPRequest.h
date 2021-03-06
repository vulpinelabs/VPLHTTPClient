//
//  VPLHTTPRequest.h
//  TrackerCore
//
//  Created by Christian Niles on 5/13/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VPLHTTPRequest <NSObject>

// ===== REQUEST METHOD ================================================================================================

@property (nonatomic,readonly,retain) NSString * requestMethod;

// ===== URL STRING ====================================================================================================

@property (nonatomic,readonly,retain) NSString * requestURLString;

- (NSURL *)requestURL;

// ===== HEADERS =======================================================================================================

@property (nonatomic,readonly,retain) NSDictionary * requestHeaders;

- (void)addRequestHeader:(NSString *)headerName
                   value:(NSString *)headerValue;

// ===== REQUEST BODY ==================================================================================================

@property (nonatomic,retain) NSData * requestBody;

// ===== AUTHENTICATION ================================================================================================

@property (nonatomic,readonly,retain) NSString * username;
@property (nonatomic,readonly,retain) NSString * password;

- (void)setUsername:(NSString *)username
           password:(NSString *)password;

// ===== REQUEST TIMEOUT ===============================================================================================

@property (nonatomic,assign) NSTimeInterval requestTimeout;

// ===== VALIDATES SSL CERTIFICATES ====================================================================================

@property (nonatomic,assign) BOOL validatesSSLCertificates;

@end
