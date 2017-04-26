//
//  MapBaseViewController.m
//  Brainbean
//
//  Created by Iryna Didkovska on 4/25/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "MapBaseViewController.h"
#import "AppleCLGeocoder.h"
#import "MGGeocoding.h"

@interface MapBaseViewController ()

@end

@implementation MapBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)useGeocodingType:(kGeocodingType)geocodingType
{
    if (geocodingType == kGeocodingApple)
        self.geocoder = [[AppleCLGeocoder alloc] init];
    else if (geocodingType == kGeocodingMapQuest)
        self.geocoder = [[MGGeocoding alloc] init];
}

@end
