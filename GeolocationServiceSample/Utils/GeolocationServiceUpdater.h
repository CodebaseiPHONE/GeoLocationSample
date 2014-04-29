//
//  GeolocationServiceUpdater.h
//  GeolocationServiceSample
//
//  Created by dbgmacmini2 dbg on 13/03/14.
//  Copyright (c) 2014 codebase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef  void (^UpdatedLocation)(CLLocation*);

@class CLLocationManager;

@interface GeolocationServiceUpdater : NSObject <CLLocationManagerDelegate>
@property(strong,nonatomic) CLLocationManager* clLocationManager;
@property(strong,nonatomic) UpdatedLocation locationUpdate;
+(BOOL)isGeoLocationEnabled;
-(id)init;
-(void)scanForCurrentLocation;
-(void)getUpdatedLocation:(UpdatedLocation)locationUpdater;
@end
