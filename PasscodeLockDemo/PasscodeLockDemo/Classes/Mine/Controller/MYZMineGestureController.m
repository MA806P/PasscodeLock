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

NSString * const item1LabelText = @"手势密码";
NSString * const item2LabelText = @"显示手势轨迹";


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
    
    BOOL isSwitchOn = [[NSUserDefaults standardUserDefaults] boolForKey:item1LabelText];
    MYZSettingSwitchItem * item1 = [MYZSettingSwitchItem settingItemWithIconName:nil andLabelText:item1LabelText];
    item1.switchOn = isSwitchOn;
    
    if (isSwitchOn)
    {
        MYZSettingSwitchItem * item2 = [MYZSettingSwitchItem settingItemWithIconName:nil andLabelText:item2LabelText];
        item2.switchOn = [[NSUserDefaults standardUserDefaults] boolForKey:item2LabelText];
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
    if([item.labelText isEqualToString:item1LabelText])
    {
        __weak typeof(self) weakSelf = self;
        
        MYZNextViewController * nvc = [[MYZNextViewController alloc] init];
        nvc.locked = item.isSwitchOn;
        nvc.lockBlock = ^(BOOL locked){
            [[NSUserDefaults standardUserDefaults] setBool:locked forKey:item1LabelText];
            
            if (locked && !item.isSwitchOn)
            {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item2LabelText];
            }
            else if (!locked && item.isSwitchOn)
            {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:item2LabelText];
            }
            [weakSelf resetDatasourceArray];
            [weakSelf.tableView reloadData];
        };
        
        [self presentViewController:nvc animated:YES completion:nil];
        
    }
    else if([item.labelText isEqualToString:item2LabelText])
    {
        item.switchOn = !item.isSwitchOn;
        NSLog(@" 显示手势轨迹 %d ",item.isSwitchOn);
        [[NSUserDefaults standardUserDefaults] setBool:item.isSwitchOn forKey:item2LabelText];
    }
    
}






@end
