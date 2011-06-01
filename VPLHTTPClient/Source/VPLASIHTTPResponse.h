//
//  VPLASIHTTPResponse.h
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/24/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPResponseBase.h"

@class ASIHTTPRequest;

@interface VPLASIHTTPResponse : VPLHTTPResponseBase {
@private
  ASIHTTPRequest * _asiHttpRequest;
}

- (id)initWithRequest:(ASIHTTPRequest *)request;
+ (VPLASIHTTPResponse *)responseWithRequest:(ASIHTTPRequest *)request;

// ===== HTTP REQUEST ==================================================================================================

- (ASIHTTPRequest *)_httpRequest;

// ===== ERROR =========================================================================================================

+ (NSError *)errorWithASIError:(NSError *)requestInError;

@end
