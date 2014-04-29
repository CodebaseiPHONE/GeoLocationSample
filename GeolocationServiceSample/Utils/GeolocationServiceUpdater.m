//
//  GeolocationServiceUpdater.m
//  GeolocationServiceSample
//
//  Created by dbgmacmini2 dbg on 13/03/14.
//  Copyright (c) 2014 codebase. All rights reserved.
//

#import "GeolocationServiceUpdater.h"
#import <CoreLocation/CoreLocation.h>
@implementation GeolocationServiceUpdater
@synthesize clLocationManager,locationUpdate;
- (id)init
{
    self = [super init];
    if (self) {
        clLocationManager = [[CLLocationManager alloc]init];
        [clLocationManager setDelegate:self];
        clLocationManager.distanceFilter = kCLDistanceFilterNone;
        clLocationManager.desiredAccuracy = 2.0f;
     
//        [self performSelector:NSSelectorFromString(@"scanForCurrentLocation") withObject:nil afterDelay:1000];
        [self scanForCurrentLocation];
              
    }
    return self;
}
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
////    NSLog(@"Locations Found %@",locations);
////    [locations lastObject];
//    locationUpdate([locations lastObject]);
////    [clLocationManager stopUpdatingLocation];
//}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    NSLog(@"Location Found %@",newLocation);
    CLLocationDistance distance = [newLocation distanceFromLocation:oldLocation];
    if (distance>=10 )
    
    {
        locationUpdate(newLocation);
    }
    
    
}
+(BOOL)isGeoLocationEnabled
{
    return  [CLLocationManager locationServicesEnabled];
}
-(void)scanForCurrentLocation
{
    if([GeolocationServiceUpdater isGeoLocationEnabled])
    {
                  [clLocationManager startUpdatingLocation];
    }
    else
    {
        NSLog(@"Location Not Enabled");
    }
    
}
-(void)getUpdatedLocation:(UpdatedLocation)locationUpdater
{
    self.locationUpdate = locationUpdater;
}
@end
