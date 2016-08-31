//
//  MYZSettingItem.h
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/20.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYZSettingItem : NSObject

@property (nonatomic, copy) NSString * iconName;

@property (nonatomic, copy) NSString * labelText;

- (instancetype)initWithIconName:(NSString *)iconName andLabelText:(NSString *)labelText;
+ (id)settingItemWithIconName:(NSString *)iconName andLabelText:(NSString *)labelText;

@end
