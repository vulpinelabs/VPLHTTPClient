//
//  VPLHTTPGenericRequestHandler.h
//  TrackerCore
//
//  Created by Christian Niles on 5/15/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPRequestHandlerBase.h"

/*!
 *  A VPLHTTPRequestHandler implementation that returns immediately with a pre-provided NSError or VPLHTTPResponse object.
 */
@interface VPLHTTPGenericRequestHandler : VPLHTTPRequestHandlerBase {
@private
  NSPredicate * _requestPredicate;
  
  VPLHTTPResponse * _response;
  NSError * _error;
}

- (id)initWithResponse:(VPLHTTPResponse *)response;
- (id)initWithError:(NSError *)error;

// ===== REQUEST PREDICATE =============================================================================================

@property (nonatomic,retain) NSPredicate * requestPredicate;

// ===== RESPONSE ======================================================================================================

@property (nonatomic,retain) VPLHTTPResponse * response;

// ===== ERROR =========================================================================================================

@property (nonatomic,retain) NSError * error;

@end
