//
//  SettingsViewController.h
//  Brainbean_test
//
//  Created by Iryna Didkovska on 4/18/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate <NSObject>
@required
- (void)updateMapType:(kMapType)mapType geocodingType:(kGeocodingType)geocodingType;

@end

@interface SettingsViewController : UITableViewController
@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;
@end
