//
//  BaseGeocoder.h
//  Brainbean
//
//  Created by Iryna Didkovska on 4/24/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol GeocodingDelegate <NSObject>
@required
- (void)geocodingResult:(NSDictionary *)dict location:(CLLocation *)location;

@end

@interface BaseGeocoder : NSObject
@property (nonatomic, weak) id<GeocodingDelegate> delegate;
- (void)getAdressByLocation:(CLLocation *)location;
- (void)getAdressByLocation:(CLLocation *)location withCompletionHandler:(void(^)(NSDictionary * dict))completionHandler;

@end
