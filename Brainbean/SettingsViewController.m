//
//  SettingsViewController.m
//  Brainbean_test
//
//  Created by Iryna Didkovska on 4/18/17.
//  Copyright © 2017 iryna. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (nonatomic, strong) NSArray *contentList;
@property (nonatomic, strong) NSMutableArray *selectedList;
@end

@implementation SettingsViewController


- (NSDictionary *)mapsList
{
    return @{@"Apple" : @(kMapTypeApple),
             @"MapQuest" : @(kMapTypeMapQuest)};
}

- (NSDictionary *)geocodingList
{
    return @{@"AppleGeocoder" : @(kMapTypeApple),
             @"MapQuestGeocoder" : @(kMapTypeMapQuest)};
}


- (void)setupContent
{
    self.contentList = @[[self mapsList], [self geocodingList]];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContent];
    
    NSDictionary *selectedMapInfo = [[NSUserDefaults standardUserDefaults] objectForKey:SelectedMap];
    NSDictionary *selectedGeocodingInfo = [[NSUserDefaults standardUserDefaults] objectForKey:SelectedGeocoding];
    if (selectedMapInfo && selectedGeocodingInfo)
    {
        NSUInteger mapIndex = [[self mapsList].allKeys indexOfObject:selectedMapInfo.allKeys.lastObject];
        
        NSUInteger geocodingIndex = [[self geocodingList].allKeys indexOfObject:selectedGeocodingInfo.allKeys.lastObject];
        
        self.selectedList = [NSMutableArray arrayWithObjects:[NSIndexPath indexPathForRow:mapIndex inSection:0], [NSIndexPath indexPathForRow:geocodingIndex inSection:1], nil];
    } else {
        self.selectedList = [NSMutableArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], [NSIndexPath indexPathForRow:0 inSection:1], nil];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.contentList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (self.contentList.count > section)
      return ((NSDictionary *)self.contentList[section]).allKeys.count;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell" forIndexPath:indexPath];
    
    cell.textLabel.text = ((NSDictionary *)self.contentList[indexPath.section]).allKeys[indexPath.row];
    
    if ([self.selectedList containsObject:indexPath])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (![self.selectedList containsObject:indexPath])
    {
        for (NSIndexPath *selectedIndexPath in self.selectedList) {
            
            if (selectedIndexPath.section == indexPath.section)
            {
                UITableViewCell *cellSelected = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
                cellSelected.accessoryType = UITableViewCellAccessoryNone;
                [self.selectedList replaceObjectAtIndex:[self.selectedList indexOfObject:selectedIndexPath] withObject:indexPath];
                [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
                break;
            }
            
        }
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!section)
    {
        return @"Map";
    }
    
    if (section == 1)
    {
        return @"Geocoding";
    }
    
    return nil;
}


- (IBAction)doneButtonPressed:(id)sender
{
    NSIndexPath *mapIndex = [self.selectedList firstObject];
    NSIndexPath *geocodingIndex = [self.selectedList lastObject];
    
    
    NSString *mapKey = [self mapsList].allKeys[[mapIndex row]];
    NSString *geocodingKey = [self geocodingList].allKeys[[geocodingIndex row]];

    
    kMapType mapType = [[self mapsList][mapKey] integerValue];
    kGeocodingType geocodingType = [[self geocodingList][geocodingKey] integerValue];
    
    [self.delegate updateMapType:mapType geocodingType:geocodingType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@{mapKey: @(mapType)} forKey:SelectedMap];
    [[NSUserDefaults standardUserDefaults] setObject:@{geocodingKey: @(geocodingType)} forKey:SelectedGeocoding];
}



@end
