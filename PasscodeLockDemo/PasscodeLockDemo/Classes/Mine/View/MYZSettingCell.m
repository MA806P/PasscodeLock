//
//  MYZSettingCell.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/20.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZSettingCell.h"
#import "MYZSettingItem.h"
#import "MYZSettingPushItem.h"
#import "MYZSettingCheckItem.h"
#import "MYZSettingSwitchItem.h"


@interface MYZSettingCell ()

@property (nonatomic, strong) UISwitch * switchView;
@property (nonatomic, strong) UILabel * label;

@end


@implementation MYZSettingCell


- (UISwitch *)switchView
{
    if (_switchView == nil)
    {
        _switchView = [[UISwitch alloc] init];
        //_switchView.onTintColor = [UIColor blueColor];
        [_switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}


+ (id)settingCellWithTableView:(UITableView *)tableView
{
    return [tableView dequeueReusableCellWithIdentifier:SettingCellId];
}


- (void)setItemData:(MYZSettingItem *)itemData
{
    _itemData = itemData;
    
    self.textLabel.text = itemData.labelText;
    if (itemData.iconName)
    {
        self.imageView.image = [UIImage imageNamed:itemData.iconName];
    }
    
    
    if ([itemData isKindOfClass:[MYZSettingPushItem class]])
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if ([itemData isKindOfClass:[MYZSettingSwitchItem class]])
    {
        self.switchView.on = [(MYZSettingSwitchItem *)self.itemData isSwitchOn];
        self.accessoryView = self.switchView;
    }
    else
    {
        self.accessoryView = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
}

- (void)switchChanged:(UISwitch *)switchView
{
    MYZSettingSwitchItem * item = (MYZSettingSwitchItem *)self.itemData;
    item.switchOn = switchView.isOn;
    
    [[NSUserDefaults standardUserDefaults] setBool:item.isSwitchOn forKey:item.labelText];
    
}


@end
