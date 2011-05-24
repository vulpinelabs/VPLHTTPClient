//
//  VPLHTTPResponse.h
//  TrackerCore
//
//  Created by Christian Niles on 5/13/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VPLHTTPResponse <NSObject>

// ===== STATUS CODE ===================================================================================================

@property (nonatomic, readonly, assign) NSUInteger responseCode;

// ===== BODY ==========================================================================================================

@property (nonatomic, readonly, retain) NSData * responseBody;

// ===== CONTENT TYPE ==================================================================================================

@property (nonatomic, readonly, retain) NSString * responseContentType;

@end
