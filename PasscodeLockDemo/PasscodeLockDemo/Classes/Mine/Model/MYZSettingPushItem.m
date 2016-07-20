//
//  MYZSettingPushItem.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/20.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZSettingPushItem.h"

@implementation MYZSettingPushItem

+ (id)settingPushItemWithIconName:(NSString *)iconName andLabelText:(NSString *)labelText andNextClass:(Class)nextClass
{
    MYZSettingPushItem * item = [[self alloc] initWithIconName:iconName andLabelText:labelText];
    item.nextControllerClass = nextClass;
    return item;
}

@end
