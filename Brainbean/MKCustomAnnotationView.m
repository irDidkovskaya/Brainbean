//
//  MKCustomAnnotationView.m
//  Brainbean
//
//  Created by Iryna Didkovska on 4/25/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "MKCustomAnnotationView.h"
#import "AnnotationView.h"

@interface MKCustomAnnotationView()
@property (nonatomic, strong) AnnotationView *annotationCustomView;
@end


@implementation MKCustomAnnotationView


- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.enabled = YES;
        self.multipleTouchEnabled = NO;
        self.frame = CGRectMake(0, 0, 150, 150);
        self.canShowCallout = YES;
    
        
        self.annotationCustomView = [[[NSBundle mainBundle] loadNibNamed:@"AnnotationView" owner:self options:nil] lastObject];
        self.annotationCustomView.frame = self.frame;
        [self addSubview:self.annotationCustomView];
        
        [self.annotationCustomView layoutSubviews];
        
    }
    return self;
}


- (void)reloadViewWithInfo:(NSDictionary *)info
{
    
    self.centerOffset = CGPointMake(self.frame.size.width/2-PIN_ICON_OFFSET, -self.frame.size.height/2);
    [self.annotationCustomView reloadViewWithInfo:info];
    
}

@end
