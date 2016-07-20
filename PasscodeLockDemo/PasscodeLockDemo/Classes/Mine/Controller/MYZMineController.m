//
//  MYZMineController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/13.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineController.h"
#import "MYZSettingGroup.h"
#import "MYZSettingPushItem.h"

@interface MYZMineController ()

@end

@implementation MYZMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    
    
    //MYZSettingPushItem * item = [MYZSettingPushItem settingItemWithIconName:@"lock_icon" andLabelText:@"安全设置"];
    MYZSettingPushItem * item = [MYZSettingPushItem settingPushItemWithIconName:@"lock_icon" andLabelText:@"安全设置" andNextClass:[UIViewController class]];
    
    MYZSettingGroup * group = [[MYZSettingGroup alloc] init];
    //group.headerTitle = @"header title test";
    //group.footerTitle = @"footer title test";
    group.items = @[item];
    
    self.dataSources = @[group];
    
}





@end
