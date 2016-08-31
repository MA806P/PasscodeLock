//
//  MYZMineLockTypeController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/21.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineLockTypeController.h"
#import "MYZMinePasscodeController.h"
#import "MYZMineGestureController.h"

@interface MYZMineLockTypeController ()

@end

@implementation MYZMineLockTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"安全设置";
    
    MYZSettingPushItem * item1 = [MYZSettingPushItem settingPushItemWithIconName:nil andLabelText:@"手势" andNextClass:[MYZMineGestureController class]];
    MYZSettingPushItem * item2 = [MYZSettingPushItem settingPushItemWithIconName:nil andLabelText:@"密码+指纹" andNextClass:[MYZMinePasscodeController class]];
    
    MYZSettingGroup * group = [[MYZSettingGroup alloc] init];
    group.items = @[item1, item2];
    
    self.dataSources = @[group];
    
}



@end
