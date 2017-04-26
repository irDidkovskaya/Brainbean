//
//  MGLCustomAnnotationView.m
//  Brainbean
//
//  Created by Iryna Didkovska on 4/25/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "MGLCustomAnnotationView.h"
#import "AnnotationView.h"

@interface MGLCustomAnnotationView()
@property (nonatomic, strong) AnnotationView *annotationView;
@end

@implementation MGLCustomAnnotationView


- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.enabled = YES;
        self.multipleTouchEnabled = NO;
        self.frame = CGRectMake(0, 0, 150, 150);
        
        self.annotationView = [[[NSBundle mainBundle] loadNibNamed:@"AnnotationView" owner:self options:nil] lastObject];
        self.annotationView.frame = self.frame;
        [self addSubview:self.annotationView];
        
        [self.annotationView layoutSubviews];
        
    }
    
    return self;
}


- (void)reloadViewWithInfo:(NSDictionary *)info
{
    self.centerOffset = CGVectorMake(self.frame.size.width/2-PIN_ICON_OFFSET, -self.frame.size.height/2);;
    [self.annotationView reloadViewWithInfo:info];
}

@end
