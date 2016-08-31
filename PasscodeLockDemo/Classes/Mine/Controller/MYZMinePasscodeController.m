//
//  MYZMinePasscodeController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/21.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMinePasscodeController.h"
#import "MYZSettingCell.h"
#import "MYZMinePasscodeSetController.h"



@interface MYZMinePasscodeController ()<MYZSettingCellDelegate>

@end

@implementation MYZMinePasscodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码";
    
    [self resetDatasourceArray];
    
    
}



- (void)resetDatasourceArray
{
    self.dataSources = nil;
    
    BOOL isSwitchOn = [[NSUserDefaults standardUserDefaults] boolForKey:PasscodeText];
    MYZSettingSwitchItem * item1 = [MYZSettingSwitchItem settingItemWithIconName:nil andLabelText:PasscodeText];
    item1.switchOn = isSwitchOn;
    
    if (isSwitchOn)
    {
        MYZSettingGroup * group1 = [[MYZSettingGroup alloc] init];
        
         MYZSettingPushItem * item2 = [MYZSettingPushItem settingPushItemWithIconName:nil andLabelText:@"修改密码" andNextClass:[MYZMinePasscodeSetController class]];
        
        MYZSettingSwitchItem * item3 = [MYZSettingSwitchItem settingItemWithIconName:nil andLabelText:TouchIDText];
        item3.switchOn = [[NSUserDefaults standardUserDefaults] boolForKey:TouchIDText];
        
        if (item3.isSwitchOn)
        {
            MYZSettingSwitchItem * item4 = [MYZSettingSwitchItem settingItemWithIconName:nil andLabelText:RemindTouchID];
            item4.switchOn = [[NSUserDefaults standardUserDefaults] boolForKey:RemindTouchID];
            group1.items = @[item1, item2, item3, item4];
        }
        else
        {
            group1.items = @[item1, item2, item3];
        }
        
        self.dataSources = @[group1];
    }
    else
    {
        MYZSettingGroup * group1 = [[MYZSettingGroup alloc] init];
        group1.items = @[item1];
        self.dataSources = @[group1];
    }
    
    
}

- (void)settingCellChangeSwitchItem:(MYZSettingSwitchItem *)item
{
    if ([item.labelText isEqualToString:PasscodeText])
    {
        
        if (item.isSwitchOn)
        {
            //跳转密码设置页面
            [self pushToSetPasscodeWithItem:item];
        }
        else
        {
            //先判断手势密码是否是开的，不能共存
            BOOL gestureLocked = [[NSUserDefaults standardUserDefaults] boolForKey:GestureText];
            if (gestureLocked)
            {
                
                UIAlertController * avc = [UIAlertController alertControllerWithTitle:nil message:@"继续开密码解锁将关闭手势解锁" preferredStyle:UIAlertControllerStyleAlert];
                [avc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.tableView reloadData];
                }]];
                
                [avc addAction:[UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:GestureText];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    //跳转密码设置页面
                    [self pushToSetPasscodeWithItem:item];
                    
                }]];
                [self presentViewController:avc animated:YES completion:nil];
            }
            else
            {
                //跳转密码设置页面
                [self pushToSetPasscodeWithItem:item];
            }
        }
        
        
    }
    else if ([item.labelText isEqualToString:TouchIDText])
    {
        item.switchOn = !item.isSwitchOn;
        [[NSUserDefaults standardUserDefaults] setBool:item.isSwitchOn forKey:TouchIDText];
        [[NSUserDefaults standardUserDefaults] setBool:item.isSwitchOn forKey:RemindTouchID];
        [self resetDatasourceArray];
        [self.tableView reloadData];
    }
    else if ([item.labelText isEqualToString:RemindTouchID])
    {
        item.switchOn = !item.isSwitchOn;
        [[NSUserDefaults standardUserDefaults] setBool:item.isSwitchOn forKey:RemindTouchID];
    }
    
}



- (void)pushToSetPasscodeWithItem:(MYZSettingSwitchItem *)item
{
    __weak typeof(self) weakSelf = self;
    MYZMinePasscodeSetController * nvc = [[MYZMinePasscodeSetController alloc] init];
    nvc.passcodeType = item.isSwitchOn ? PasscodeSetTypeDelete : PasscodeSetTypeInstal;
    nvc.lockBlock = ^(BOOL locked){
        
        [[NSUserDefaults standardUserDefaults] setBool:locked forKey:PasscodeText];
        if (locked && !item.isSwitchOn)
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:TouchIDText];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:RemindTouchID];
        }
        else if (!locked && item.isSwitchOn)
        {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:TouchIDText];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:RemindTouchID];
        }
        
        [weakSelf resetDatasourceArray];
        [weakSelf.tableView reloadData];
    };
    
    [self.navigationController pushViewController:nvc animated:YES];
}




@end
