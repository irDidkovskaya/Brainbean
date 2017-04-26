//
//  ViewController.m
//  Brainbean_test
//
//  Created by Iryna Didkovska on 4/18/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "MainViewController.h"
#import "SettingsViewController.h"

#import "MapBaseViewController.h"
#import "MQMapViewController.h"

@interface MainViewController () <SettingsViewControllerDelegate>
@property (nonatomic, assign) CGPoint touchPoint;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *selectedMapInfo = [[NSUserDefaults standardUserDefaults] objectForKey:SelectedMap];
    NSDictionary *selectedGeocodingInfo = [[NSUserDefaults standardUserDefaults] objectForKey:SelectedGeocoding];
    
    kMapType startMapType = kMapTypeApple;
    kGeocodingType startGeocodingType = kGeocodingApple;
    
    if (selectedMapInfo && selectedGeocodingInfo)
    {
        startMapType = (kMapType)[selectedMapInfo.allValues.lastObject integerValue];
        startGeocodingType = (kGeocodingType)[selectedGeocodingInfo.allValues.lastObject integerValue];
    }
    
    [self updateMapType:startMapType geocodingType:startGeocodingType];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

    
- (void)updateMapType:(kMapType)mapType geocodingType:(kGeocodingType)geocodingType
{
    MapBaseViewController *mapBaseViewController = nil;
    if (mapType == kMapTypeMapQuest)
    {
        mapBaseViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MQMapViewController"];
    } else
    {
        mapBaseViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AppleMapViewController"];
    }

    [self addChildViewController:mapBaseViewController];
    [mapBaseViewController.view setFrame:self.view.frame];
    [self.view addSubview:mapBaseViewController.view];
    
    [mapBaseViewController useGeocodingType:geocodingType];
    
    [mapBaseViewController didMoveToParentViewController:self];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class ]])
    {
        UINavigationController *nc = segue.destinationViewController;
        
        if ([[nc.viewControllers lastObject] isKindOfClass:[SettingsViewController class]])
        {
            SettingsViewController *settingsViewController = [nc.viewControllers lastObject];
            settingsViewController.delegate = self;
        }
    }
}

@end
