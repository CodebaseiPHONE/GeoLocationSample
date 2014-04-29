//
//  GeolocationServiceSampleAppDelegate.h
//  GeolocationServiceSample
//
//  Created by dbgmacmini2 dbg on 13/03/14.
//  Copyright (c) 2014 codebase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeolocationServiceUpdater.h"
@interface GeolocationServiceSampleAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GeolocationServiceUpdater *geoLocationUpdater;
@end
