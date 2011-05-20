//
//  VPLHTTPExplodingRequestHandler.m
//  TrackerCore
//
//  Created by Christian Niles on 5/16/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import "VPLHTTPExplodingRequestHandler.h"
#import "VPLHTTPRequest.h"

@implementation VPLHTTPExplodingRequestHandler

- (BOOL)canPerformRequest:(VPLHTTPRequest *)request
{
  return YES;
}

- (void)performRequest:(VPLHTTPRequest *)request
               success:(VPLHTTPSuccessCallback)successCallback
                 error:(VPLHTTPErrorCallback)errorCallback
{
  [NSException raise:@"VPLHTTPExternalRequestsDisabledException"
              format:@"External requests are disabled: %@", request.URLString];
}

@end
