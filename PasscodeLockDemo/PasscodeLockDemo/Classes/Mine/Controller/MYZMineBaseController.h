//
//  MYZMineBaseController.h
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/20.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYZSettingGroup.h"
#import "MYZSettingItem.h"
#import "MYZSettingPushItem.h"
#import "MYZSettingCheckItem.h"
#import "MYZSettingSwitchItem.h"

static NSString * const GestureText = @"手势密码";
static NSString * const GestureRaceText = @"显示手势轨迹";

static NSString * const PasscodeText = @"密码";
static NSString * const TouchIDText = @"Touch ID";
static NSString * const RemindTouchID = @"启动时提示使用Touch ID";


@interface MYZMineBaseController : UITableViewController

@property (nonatomic, copy) NSArray * dataSources;

@end
