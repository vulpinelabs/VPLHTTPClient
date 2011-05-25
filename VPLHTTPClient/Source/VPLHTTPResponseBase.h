//
//  VPLHTTPResponseBase.h
//  VPLHTTPClient
//
//  Created by Christian Niles on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPResponse.h"

@interface VPLHTTPResponseBase : NSObject <VPLHTTPResponse> {
@private
    
}

+ (NSString *)defaultResponseStatusMessageForCode:(NSUInteger)responseCode;

// ===== CONTENT TYPE HELPERS ==========================================================================================

+ (BOOL)isXMLContentType:(NSString *)contentType;
+ (BOOL)isHTMLContentType:(NSString *)contentType;
+ (BOOL)isJSONContentType:(NSString *)contentType;
+ (BOOL)isPlainTextContentType:(NSString *)contentType;

@end
