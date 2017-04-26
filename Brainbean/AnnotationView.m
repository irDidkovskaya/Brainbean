//
//  AnnotationView.m
//  Brainbean_test
//
//  Created by Iryna Didkovska on 4/23/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "AnnotationView.h"

@interface AnnotationView()
@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation AnnotationView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.layer.borderWidth = 1;
}

- (void)reloadViewWithInfo:(NSDictionary *)info
{
    NSMutableString *text = [NSMutableString string];
    for (NSString *key in info.keyEnumerator) {
        
        if ([info[key] isKindOfClass:[NSString class]] && [(NSString *)info[key] length])
            [text appendFormat:@"%@: %@\n", key, info[key]];
        else if ([info[key] isKindOfClass:[NSArray class]] && [(NSArray *)info[key] count])
        [text appendFormat:@"%@: %@\n", key, [info[key] componentsJoinedByString:@", "]];
    }
    
    self.textView.text = text;
    
    [self layoutSubviews];
}



@end
