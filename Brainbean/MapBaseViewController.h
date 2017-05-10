//
//  MapBaseViewController.h
//  Brainbean
//
//  Created by Iryna Didkovska on 4/25/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Geocoder.h"

@interface MapBaseViewController : UIViewController
@property (nonatomic, strong) id<Geocoder> geocoder;

- (void)useGeocodingType:(kGeocodingType)geocodingType;
@end
