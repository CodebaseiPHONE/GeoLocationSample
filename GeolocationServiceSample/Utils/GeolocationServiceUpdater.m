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
@synthesize clLocationManager,locationUpdate,isUpdatingLocation,desiredMeterDistance;
- (id)init
{
    self = [super init];
    if (self) {
        clLocationManager = [[CLLocationManager alloc]init];
        [clLocationManager setDelegate:self];
        clLocationManager.distanceFilter = kCLDistanceFilterNone;
        desiredMeterDistance = 3.0;
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
     
//        [self performSelector:NSSelectorFromString(@"scanForCurrentLocation") withObject:nil afterDelay:1000];
//        [self scanForCurrentLocation];
        
    }
    return self;
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.isUpdatingLocation = FALSE;

    
    if ([error domain] == kCLErrorDomain) {
        
        // We handle CoreLocation-related errors here
        switch ([error code]) {
                // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
                // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
            case kCLErrorDenied:
                
            case kCLErrorLocationUnknown:
                
            default:
                break;
        }
    } else {
        // We handle all non-CoreLocation errors here
    }
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
    NSLog(@"distance is %f",distance);
    
    if (distance>=desiredMeterDistance)
    
    {
        locationUpdate(newLocation,distance);
    }
    
    
}

-(void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
     self.isUpdatingLocation = FALSE;
}
-(void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager
{
     self.isUpdatingLocation = TRUE;
}
+(BOOL)isGeoLocationEnabled
{
    
    BOOL flag1 = [CLLocationManager locationServicesEnabled];
    
    BOOL flag2 = [CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied;
    
    if(flag2)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
                                           message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
    }
//    else if(!flag1)
//    {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Location Service Disabled"
//                                                        message:@"Please enable location service in settings"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
    
    
    return flag1&&!flag2;
    
}
-(void)scanForCurrentLocation
{
    if([GeolocationServiceUpdater isGeoLocationEnabled])
    {
     
        if(!isUpdatingLocation)
        {
            NSLog(@"not scanning so started scanning");
                [clLocationManager startUpdatingLocation];
           self.isUpdatingLocation = TRUE;
        }
        else{
            NSLog(@"already scanning");
        }
    }
    else
    {
        NSLog(@"Location Not Enabled");
    }
    
}
-(void)stopScanningLocations
{
    
    [clLocationManager stopUpdatingLocation];
       self.isUpdatingLocation = FALSE;
    
}
-(CLLocation*)getLastKnowLocation
{
    
    return clLocationManager.location;
    
}
+(CLLocation*)getLastKnowLocation
{
    GeolocationServiceUpdater* updater = [GeolocationServiceUpdater getSharedGeoLocationUpdater];
    return [updater getLastKnowLocation];
}
+(void)startScaningForLocationChange
{
    GeolocationServiceUpdater* updater = [GeolocationServiceUpdater getSharedGeoLocationUpdater];
    [updater scanForCurrentLocation];
}
+(void)stopScanningForLocationChange
{
    GeolocationServiceUpdater* updater = [GeolocationServiceUpdater getSharedGeoLocationUpdater];
    [updater stopScanningLocations];
}
-(void)getUpdatedLocation:(UpdatedLocation)locationUpdater
{
    self.locationUpdate = locationUpdater;
}
+(GeolocationServiceUpdater*)getSharedGeoLocationUpdater
{
    static GeolocationServiceUpdater *_geoLocationServiceUpdater = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _geoLocationServiceUpdater = [[GeolocationServiceUpdater alloc] init];
       
    });
    
    return _geoLocationServiceUpdater;

}
+(void)setDesiredMeterDistance:(float)meters
{
    GeolocationServiceUpdater* updater = [GeolocationServiceUpdater getSharedGeoLocationUpdater];
    updater.desiredMeterDistance = meters;
}
+(void)getUpdatedLocation:(UpdatedLocation)locationUpdater
{
    GeolocationServiceUpdater* updater = [GeolocationServiceUpdater getSharedGeoLocationUpdater];
    [updater getUpdatedLocation:locationUpdater];
}
@end
