//
//  VPLHTTPRequestHandlerImpl.m
//  TrackerCore
//
//  Created by Christian Niles on 5/16/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import "VPLHTTPRequestHandlerBase.h"


@implementation VPLHTTPRequestHandlerBase

- (BOOL)canPerformRequest:(VPLHTTPRequest *)request
{
  return NO;
}

- (void)performRequest:(VPLHTTPRequest *)request
               success:(VPLHTTPSuccessCallback)successCallback
                 error:(VPLHTTPErrorCallback)errorCallback
{
  NSError * error = [NSError errorWithDomain:VPLHTTPErrorDomain
                                        code:VPLHTTPRequestNotPerformedError
                                    userInfo:[NSDictionary dictionaryWithObject:request forKey:@"request"]];
  errorCallback(error);
}

@end
