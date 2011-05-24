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

@property (nonatomic,readonly,retain) NSString * URLString;

- (NSURL *)URL;

// ===== HEADERS =======================================================================================================

@property (nonatomic,readonly,retain) NSDictionary * requestHeaders;

- (void)addRequestHeader:(NSString *)headerName
                   value:(NSString *)headerValue;

// ===== AUTHENTICATION ================================================================================================

@property (nonatomic,readonly,retain) NSString * username;
@property (nonatomic,readonly,retain) NSString * password;

- (void)setUsername:(NSString *)username
           password:(NSString *)password;

@end
