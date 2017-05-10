//
//  MGGeocoding.h
//  Brainbean
//
//  Created by Iryna Didkovska on 4/24/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Geocoder.h"


@interface MGGeocoding : NSObject <Geocoder>

@property (nonatomic, weak) id<GeocodingDelegate> delegate;
- (void)getAdressByLocation:(CLLocation *)location;
- (void)getAdressByLocation:(CLLocation *)location withCompletionHandler:(void(^)(NSDictionary * dict))completionHandler;

@end
