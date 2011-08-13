//
//  VPLHTTPGenericRequest.h
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/23/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPRequest.h"

@interface VPLHTTPGenericRequest : NSObject <VPLHTTPRequest> {
@private
  NSString * _requestMethod;
  NSString * _requestURLString;
  
  NSMutableDictionary * _requestHeaders;
  NSData * _requestBody;
  
  NSString * _username;
  NSString * _password;
  
  NSTimeInterval _requestTimeout;
  BOOL _validatesSSLCertificates;
}

- (id)initWithURLString:(NSString *)URLString;

- (id)initWithURLString:(NSString *)URLString
                 method:(NSString *)requestMethod;

// ===== REQUEST METHOD ================================================================================================

@property (nonatomic,retain) NSString * requestMethod;

// ===== URL STRING ====================================================================================================

@property (nonatomic,retain) NSString * requestURLString;

@end
