//
//  VPLHTTPRequest.h
//  TrackerCore
//
//  Created by Christian Niles on 5/13/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPMessage.h"

@interface VPLHTTPRequest : VPLHTTPMessage {
@private
  NSString * _requestMethod;
  NSString * _URLString;
}

- (id)initWithURLString:(NSString *)URLString;

// ===== REQUEST METHOD ================================================================================================

@property (nonatomic,retain) NSString * requestMethod;

// ===== URL STRING ====================================================================================================

@property (nonatomic,retain) NSString * URLString;
- (NSURL *)URL;

@end
