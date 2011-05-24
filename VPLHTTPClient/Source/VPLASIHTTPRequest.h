//
//  VPLASIHTTPRequest.h
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPRequest.h"
#import "VPLHTTPResponse.h"

@class ASIHTTPRequest;

@interface VPLASIHTTPRequest : NSObject <VPLHTTPRequest,VPLHTTPResponse> {
@private
  ASIHTTPRequest * _asiHttpRequest;
}

@end
