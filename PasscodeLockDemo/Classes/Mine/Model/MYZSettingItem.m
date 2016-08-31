//
//  MYZSettingItem.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/20.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZSettingItem.h"

@implementation MYZSettingItem

- (instancetype)initWithIconName:(NSString *)iconName andLabelText:(NSString *)labelText
{
    if (self = [super init])
    {
        self.iconName = iconName;
        self.labelText = labelText;
    }
    return self;
}

+ (id)settingItemWithIconName:(NSString *)iconName andLabelText:(NSString *)labelText
{
    return [[self alloc] initWithIconName:iconName andLabelText:labelText];
}



@end
