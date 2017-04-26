//
//  Annotation.m
//  Brainbean_test
//
//  Created by Iryna Didkovska on 4/24/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "Annotation.h"

@interface Annotation()
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end

@implementation Annotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate dictData:(NSDictionary *)dictData {
    if (self = [super init]) {
        self.coordinate = coordinate;
        self.dictData = dictData;
    }
    return self;
}

- (NSString *)subtitle
{
    return nil;
}
    
- (NSString *)title
{
    return nil;
}

@end
