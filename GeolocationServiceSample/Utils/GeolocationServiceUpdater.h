//
//  GeolocationServiceUpdater.h
//  GeolocationServiceSample
//
//  Created by dbgmacmini2 dbg on 13/03/14.
//  Copyright (c) 2014 codebase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef  void (^UpdatedLocation)(CLLocation*,CLLocationDistance);

@class CLLocationManager;

@interface GeolocationServiceUpdater : NSObject <CLLocationManagerDelegate>
@property(strong,nonatomic) CLLocationManager* clLocationManager;
@property(nonatomic) BOOL isUpdatingLocation;
@property(nonatomic) float desiredMeterDistance;
@property(strong,nonatomic) UpdatedLocation locationUpdate;
+(BOOL)isGeoLocationEnabled;
+(void)getUpdatedLocation:(UpdatedLocation)locationUpdater;
+(GeolocationServiceUpdater*)getSharedGeoLocationUpdater;
+(void)stopScanningForLocationChange;
+(void)startScaningForLocationChange;
+(CLLocation*)getLastKnowLocation;
+(void)setDesiredMeterDistance:(float)meters;
@end
