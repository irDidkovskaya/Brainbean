//
//  MKCustomAnnotationView.h
//  Brainbean
//
//  Created by Iryna Didkovska on 4/25/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKCustomAnnotationView : MKAnnotationView
- (void)reloadViewWithInfo:(NSDictionary *)info;
@end
