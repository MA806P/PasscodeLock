//
//  MYZSettingPushItem.h
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/20.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZSettingItem.h"

@interface MYZSettingPushItem : MYZSettingItem

@property (nonatomic, assign) Class nextControllerClass;

+ (id)settingPushItemWithIconName:(NSString *)iconName andLabelText:(NSString *)labelText andNextClass:(Class)nextClass;

@end
