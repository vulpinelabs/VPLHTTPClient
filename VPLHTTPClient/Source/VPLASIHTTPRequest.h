//
//  VPLASIHTTPRequest.h
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPRequest.h"

@class ASIHTTPRequest;

@interface VPLASIHTTPRequest : NSObject <VPLHTTPRequest> {
@private
  ASIHTTPRequest * _asiHttpRequest;
}

- (id)initWithURL:(NSURL *)requestURL;
- (id)initWithURL:(NSURL *)requestURL
           method:(NSString *)requestMethod;

- (id)initWithURLString:(NSString *)requestURLString;
- (id)initWithURLString:(NSString *)requestURLString
                 method:(NSString *)requestMethod;

- (ASIHTTPRequest *)_httpRequest;

@end
