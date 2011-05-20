//
//  VPLHTTPExplodingRequestHandler.h
//  TrackerCore
//
//  Created by Christian Niles on 5/16/11.
//  Copyright 2011 Vulpine Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPLHTTPRequestHandler.h"

/*!
 *  A VPLHTTPRequestHandler implementation that raises an exception. This is only useful for testing.
 */
@interface VPLHTTPExplodingRequestHandler : NSObject <VPLHTTPRequestHandler> {
@private
    
}

@end
