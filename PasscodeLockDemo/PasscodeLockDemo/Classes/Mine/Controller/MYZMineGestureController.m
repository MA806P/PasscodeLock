//
//  MYZMineGestureController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/21.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineGestureController.h"
#import "MYZNextViewController.h"
#import "MYZSettingCell.h"

@interface MYZMineGestureController () <MYZSettingCellDelegate>

@end

@implementation MYZMineGestureController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势";
    
    [self resetDatasourceArray];
    
}


- (void)resetDatasourceArray
{
    self.dataSources = nil;
    
    BOOL isSwitchOn = [[NSUserDefaults standardUserDefaults] boolForKey:GestureText];
    MYZSettingSwitchItem * item1 = [MYZSettingSwitchItem settingItemWithIconName:nil andLabelText:GestureText];
    item1.switchOn = isSwitchOn;
    
    if (isSwitchOn)
    {
        MYZSettingSwitchItem * item2 = [MYZSettingSwitchItem settingItemWithIconName:nil andLabelText:GestureRaceText];
        item2.switchOn = [[NSUserDefaults standardUserDefaults] boolForKey:GestureRaceText];
        MYZSettingGroup * group1 = [[MYZSettingGroup alloc] init];
        group1.items = @[item1, item2];
        
        MYZSettingPushItem * item3 = [MYZSettingPushItem settingPushItemWithIconName:nil andLabelText:@"修改手势密码" andNextClass:[UIViewController class]];
        MYZSettingGroup * group2 = [[MYZSettingGroup alloc] init];
        group2.items = @[item3];
        
        self.dataSources = @[group1, group2];
    }
    else
    {
        MYZSettingGroup * group1 = [[MYZSettingGroup alloc] init];
        group1.items = @[item1];
        self.dataSources = @[group1];
    }

    
}


#pragma mark - MYZSetting cell delegate

- (void)settingCellChangeSwitchItem:(MYZSettingSwitchItem *)item
{
    if([item.labelText isEqualToString:GestureText])
    {
        __weak typeof(self) weakSelf = self;
        
        MYZNextViewController * nvc = [[MYZNextViewController alloc] init];
        nvc.locked = item.isSwitchOn;
        nvc.lockBlock = ^(BOOL locked){
            [[NSUserDefaults standardUserDefaults] setBool:locked forKey:GestureText];
            
            if (locked && !item.isSwitchOn)
            {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:GestureRaceText];
            }
            else if (!locked && item.isSwitchOn)
            {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:GestureRaceText];
            }
            [weakSelf resetDatasourceArray];
            [weakSelf.tableView reloadData];
        };
        
        [self presentViewController:nvc animated:YES completion:nil];
        
    }
    else if([item.labelText isEqualToString:GestureRaceText])
    {
        item.switchOn = !item.isSwitchOn;
        NSLog(@" 显示手势轨迹 %d ",item.isSwitchOn);
        [[NSUserDefaults standardUserDefaults] setBool:item.isSwitchOn forKey:GestureRaceText];
    }
    
}






@end
