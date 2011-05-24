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

@property (nonatomic, assign) NSUInteger responseCode;

// ===== BODY ==========================================================================================================

@property (nonatomic, retain) NSData * responseBody;

// ===== CONTENT TYPE ==================================================================================================

@property (nonatomic, retain) NSString * responseContentType;

@end
