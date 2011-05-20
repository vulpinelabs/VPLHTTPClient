//
//  VPLHTTPResponse.h
//  TrackerCore
//
//  Created by Christian Niles on 5/13/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPMessage.h"

/*!
 *  Encapsulates data about an HTTP response. It is passed to a callback by HTTPClient when an HTTP request is
 *  successfully completed.
 */
@interface VPLHTTPResponse : VPLHTTPMessage {
@private
  NSUInteger _statusCode;
  NSData * _body;
  NSString * _contentType;
}

- (id)initWithStatusCode:(NSUInteger)statusCode
                    body:(NSData *)body
             contentType:(NSString *)contentType;

// ===== STATUS CODE ===================================================================================================

@property (nonatomic, assign) NSUInteger statusCode;

// ===== BODY ==========================================================================================================

@property (nonatomic, retain) NSData * body;

// ===== CONTENT TYPE ==================================================================================================

@property (nonatomic, retain) NSString * contentType;

// ===== RESPONSE HELPERS ==============================================================================================

/*!
 *  Returns a response with a 200 (Success) status code, and an empty text body.
 */
+ (VPLHTTPResponse *)response;

/*!
 *  Returns a response with a 200 (Success) status code, and the given XML in its body.
 */
+ (VPLHTTPResponse *)responseWithXML:(NSString *)xmlString;

@end
