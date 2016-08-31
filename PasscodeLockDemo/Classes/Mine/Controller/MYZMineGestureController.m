//
//  MYZMineGestureController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/21.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineGestureController.h"
#import "MYZSettingCell.h"
#import "MYZMineGestureSetController.h"

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
        MYZSettingSwitchItem * item2 = [MYZSettingSwitchItem settingItemWithIconName:nil andLabelText:GesturePathText];
        item2.switchOn = [[NSUserDefaults standardUserDefaults] boolForKey:GesturePathText];
        MYZSettingGroup * group1 = [[MYZSettingGroup alloc] init];
        group1.items = @[item1, item2];
        
        MYZSettingPushItem * item3 = [MYZSettingPushItem settingPushItemWithIconName:nil andLabelText:@"修改手势密码" andNextClass:[MYZMineGestureSetController class]];
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
        
        BOOL gestureLocked = [[NSUserDefaults standardUserDefaults] boolForKey:GestureText];
        __weak typeof(self) weakSelf = self;
        
        //如果手势密码是开的，点击switch跳转验证手势页面删除手势
        if (gestureLocked)
        {
            MYZMineGestureSetController * gestureSetVC = [[MYZMineGestureSetController alloc] init];
            gestureSetVC.gestureSetType = GestureSetTypeDelete;
            gestureSetVC.lockBlock = ^(BOOL locked){
                [[NSUserDefaults standardUserDefaults] setBool:locked forKey:GestureText];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //关闭手势密码
                if (!locked && item.isSwitchOn)
                {
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:GesturePathText];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                [weakSelf resetDatasourceArray];
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:gestureSetVC animated:YES];
            
            
        }
        //如果手势是关闭的，点击switch打开跳转设置手势页面
        else
        {
            //先判断数字密码是否是开的，不能共存
            BOOL passcodeLocked = [[NSUserDefaults standardUserDefaults] boolForKey:PasscodeText];
            if (passcodeLocked)
            {
                
                UIAlertController * avc = [UIAlertController alertControllerWithTitle:nil message:@"继续开启手势解锁将关闭密码解锁" preferredStyle:UIAlertControllerStyleAlert];
                [avc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.tableView reloadData];
                }]];
                
                [avc addAction:[UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:PasscodeText];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    //跳转手势设置页面
                    [weakSelf pushToSetGestureWithItem:item];
                    
                }]];
                [weakSelf presentViewController:avc animated:YES completion:nil];
            }
            else
            {
                //跳转手势设置页面
                [weakSelf pushToSetGestureWithItem:item];
            }
            
            
        }
        
    }
    else if([item.labelText isEqualToString:GesturePathText])
    {
        item.switchOn = !item.isSwitchOn;
        [[NSUserDefaults standardUserDefaults] setBool:item.isSwitchOn forKey:GesturePathText];
    }
    
}



- (void)pushToSetGestureWithItem:(MYZSettingSwitchItem *)item
{
    MYZMineGestureSetController * gestureSetVC = [[MYZMineGestureSetController alloc] init];
    gestureSetVC.gestureSetType = GestureSetTypeInstall;
    gestureSetVC.lockBlock = ^(BOOL locked){
        [[NSUserDefaults standardUserDefaults] setBool:locked forKey:GestureText];
        
        if (locked && !item.isSwitchOn)
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:GesturePathText];
        }
        [self resetDatasourceArray];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:gestureSetVC animated:YES];
    
}




@end
