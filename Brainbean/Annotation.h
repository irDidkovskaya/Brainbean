//
//  Annotation.h
//  Brainbean_test
//
//  Created by Iryna Didkovska on 4/24/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation, MGLAnnotation>
@property (nonatomic, strong) NSDictionary *dictData;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate dictData:(NSDictionary *)dictData;
@end
