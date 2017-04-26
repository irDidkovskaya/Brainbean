//
//  MGLCustomAnnotationView.h
//  Brainbean
//
//  Created by Iryna Didkovska on 4/25/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import <Mapbox/Mapbox.h>

@interface MGLCustomAnnotationView : MGLAnnotationView
- (void)reloadViewWithInfo:(NSDictionary *)info;
@end
