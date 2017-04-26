//
//  CLGeocoder.m
//  Brainbean
//
//  Created by Iryna Didkovska on 4/24/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "AppleCLGeocoder.h"

@interface AppleCLGeocoder()

@property (nonatomic, strong) CLGeocoder *geocoder;

@end


@implementation AppleCLGeocoder


- (instancetype)init
{
    if (self == [super init])
    {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    return self;
}


- (void)getAdressByLocation:(CLLocation *)location
{
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (!placemarks || !placemarks.count)
        {
            NSLog(@"AppleCLGeocoder Error geocodingResult: placemarks nil");
            return;
        }
        
        CLPlacemark *placemark = [placemarks lastObject];
        
        NSLog(@"AppleCLGeocoder placemarks = %@", placemark.addressDictionary);
        
        if ([self.delegate respondsToSelector:@selector(geocodingResult:location:)])
            [self.delegate geocodingResult:placemark.addressDictionary location:location];
        
    }];
    
    
}
- (void)getAdressByLocation:(CLLocation *)location withCompletionHandler:(void(^)(NSDictionary * dict))completionHandler
{
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (!placemarks || !placemarks.count)
        {
            NSLog(@"AppleCLGeocoder Error geocodingResult: placemarks nil");
            return;
        }
        
        CLPlacemark *placemark = [placemarks lastObject];
        NSLog(@"AppleCLGeocoder placemarks = %@", placemark.addressDictionary);
        
        completionHandler(placemark.addressDictionary);
        
    }];
}

@end
