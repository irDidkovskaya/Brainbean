//
//  Geocoder.h
//  Brainbean
//
//  Created by Alexey Pelykh on 5/10/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#ifndef Geocoder_h
#define Geocoder_h

@protocol GeocodingDelegate <NSObject>
@required
- (void)geocodingResult:(NSDictionary *)dict location:(CLLocation *)location;
@end

@protocol Geocoder
@required
@property (nonatomic, weak) id<GeocodingDelegate> delegate;
- (void)getAdressByLocation:(CLLocation *)location;
- (void)getAdressByLocation:(CLLocation *)location withCompletionHandler:(void(^)(NSDictionary * dict))completionHandler;
@end

#endif /* Geocoder_h */
