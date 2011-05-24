//
//  VPLHTTPGenericRequest.h
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPRequest.h"

@interface VPLHTTPGenericRequest : NSObject <VPLHTTPRequest> {
@private
  NSString * _requestMethod;
  NSString * _URLString;
}

// ===== REQUEST METHOD ================================================================================================

@property (nonatomic,retain) NSString * requestMethod;

// ===== URL STRING ====================================================================================================

@property (nonatomic,retain) NSString * URLString;
- (NSURL *)URL;

@end
