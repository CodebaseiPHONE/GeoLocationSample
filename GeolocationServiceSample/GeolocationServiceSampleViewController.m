//
//  GeolocationServiceSampleViewController.m
//  GeolocationServiceSample
//
//  Created by dbgmacmini2 dbg on 13/03/14.
//  Copyright (c) 2014 codebase. All rights reserved.
//

#import "GeolocationServiceSampleViewController.h"
#import "GeolocationServiceSampleAppDelegate.h"
#import "GeolocationServiceUpdater.h"
@interface GeolocationServiceSampleViewController ()

@end

@implementation GeolocationServiceSampleViewController
@synthesize textViewLog;
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    GeolocationServiceSampleAppDelegate* delegate = [[UIApplication sharedApplication]delegate];
    
    [delegate.geoLocationUpdater getUpdatedLocation:^(CLLocation* location) {
        
       textViewLog.text = [textViewLog.text stringByAppendingString:[NSString stringWithFormat:@"%@\n\n%@",textViewLog.text,location]];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@ ",searchBar.text);
    searchBar.text = @"current location name";
    
}

@end
