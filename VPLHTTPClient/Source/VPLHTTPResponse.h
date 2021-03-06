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
@property (nonatomic, readonly, retain) NSString * responseStatusMessage;

// ===== BODY ==========================================================================================================

@property (nonatomic, readonly, retain) NSData * responseBody;
@property (nonatomic, readonly, retain) NSString * responseString;

// ===== CONTENT TYPE ==================================================================================================

@property (nonatomic, readonly, retain) NSString * responseContentType;
@property (nonatomic, readonly, assign) NSStringEncoding responseEncoding;

- (BOOL)isXML;
- (BOOL)isHTML;
- (BOOL)isJSON;
- (BOOL)isPlainText;

@end
