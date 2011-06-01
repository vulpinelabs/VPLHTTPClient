//
//  VPLHTTPGenericResponse.h
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/23/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPResponseBase.h"

@interface VPLHTTPGenericResponse : VPLHTTPResponseBase {
@private
  NSUInteger _responseCode;
  NSData * _responseBody;
  NSString * _responseContentType;
}

- (id)initWithResponseCode:(NSUInteger)statusCode
                      body:(NSData *)body
               contentType:(NSString *)contentType;

// ===== RESPONSE HELPERS ==============================================================================================

/*!
 *  Returns an empty 200 (Success) response.
 */
+ (NSObject <VPLHTTPResponse> *)response;

/*!
 *  Returns a response with a 200 (Success) status code, and the given XML in its body.
 */
+ (NSObject <VPLHTTPResponse> *)responseWithXML:(NSString *)xmlString;

/*!
 *  Returns an empty 404 (Not Found) response.
 */
+ (NSObject <VPLHTTPResponse> *)notFoundResponse;

@end
