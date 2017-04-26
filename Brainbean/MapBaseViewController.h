//
//  MapBaseViewController.h
//  Brainbean
//
//  Created by Iryna Didkovska on 4/25/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseGeocoder.h"

@interface MapBaseViewController : UIViewController
@property (nonatomic, strong) BaseGeocoder *geocoder;

- (void)useGeocodingType:(kGeocodingType)geocodingType;
@end
