//
//  VPLHTTPRequest.m
//  TrackerCore
//
//  Created by Christian Niles on 5/13/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import "VPLHTTPRequest.h"

@implementation VPLHTTPRequest

- (id)initWithURLString:(NSString *)URLString
{
  self = [self init];
  if (self != nil) {
    
    _URLString = [URLString retain];
    _requestMethod = [@"GET" retain];
    
  }
  return self;
}

- (void)dealloc
{
  [_URLString release];
  [_requestMethod release];
  
  [super dealloc];
}


// ===== REQUEST METHOD ================================================================================================
#pragma mark -
#pragma mark Request Method

@synthesize requestMethod=_requestMethod;

// ===== URL STRING ====================================================================================================
#pragma mark -
#pragma mark URL String

@synthesize URLString=_URLString;

- (NSURL *)URL
{
  if (self.URLString != nil) {
    return [NSURL URLWithString:self.URLString];
  } else {
    return nil;
  }
}

@end