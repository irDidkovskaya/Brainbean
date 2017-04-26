//
//  MGGeocoding.m
//  Brainbean
//
//  Created by Iryna Didkovska on 4/24/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "MGGeocoding.h"


#define URL(location) [NSString stringWithFormat:@"http://www.mapquestapi.com/geocoding/v1/reverse?key=R94udE9nfogs2m0z2xPJGO0WWwb6qA3x&location=%@&includeRoadMetadata=true&includeNearestIntersection=true&outFormat=json", location]


@interface MGGeocoding()

@property (nonatomic, strong) NSURLSession *defaultSession;

@end

@implementation MGGeocoding


- (instancetype)init
{
    if (self == [super init])
    {
        self.defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}


- (void)getAdressByLocation:(CLLocation *)location
{
    
    NSString *locationString = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:URL(locationString)];
    
    NSURLSessionDataTask *dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *errorJson = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorJson];
        
        if (!json || ![json isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Error MGGeocoding get adress: json nil");
            return;
        }
        
        
        NSDictionary *locationsDict = [(NSArray *)json[@"results"] lastObject];
        if ([self.delegate respondsToSelector:@selector(geocodingResult:location:)])
            [self.delegate geocodingResult:[locationsDict[@"locations"] lastObject] location:location];
        
        NSLog(@"MGGeocoding json = %@", locationsDict[@"locations"]);
        
    }];
    
    [dataTask resume];
}


- (void)getAdressByLocation:(CLLocation *)location withCompletionHandler:(void(^)(NSDictionary * dict))completionHandler
{
    
    NSString *locationString = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:URL(locationString)];
    
    NSURLSessionDataTask *dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *errorJson = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorJson];
        
        
        if (!json || ![json isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Error MGGeocoding get adress: json nil");
            return;
        }
        
        NSDictionary *locationsDict = [(NSArray *)json[@"results"] lastObject];
        
        NSLog(@"MGGeocoding json = %@", locationsDict[@"locations"]);
        
        completionHandler([locationsDict[@"locations"] lastObject]);
        
    }];
    
    [dataTask resume];
}


@end
