//
//  VPLHTTPGenericRequestHandler.h
//  TrackerCore
//
//  Created by Christian Niles on 5/15/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPRequestHandler.h"

/*!
 *  A VPLHTTPRequestHandler implementation that returns immediately with a pre-provided NSError or VPLHTTPResponse object.
 */
@interface VPLHTTPGenericRequestHandler : NSObject <VPLHTTPRequestHandler> {
@private
  NSPredicate * _requestPredicate;
  NSObject <VPLHTTPResponse> * _response;
  NSError * _error;
}

- (id)initWithResponse:(NSObject <VPLHTTPResponse> *)response;
- (id)initWithError:(NSError *)error;

// ===== REQUEST PREDICATE =============================================================================================

@property (nonatomic,retain) NSPredicate * requestPredicate;

// ===== RESPONSE ======================================================================================================

@property (nonatomic,retain) NSObject <VPLHTTPResponse> * response;

// ===== ERROR =========================================================================================================

@property (nonatomic,retain) NSError * error;

@end
