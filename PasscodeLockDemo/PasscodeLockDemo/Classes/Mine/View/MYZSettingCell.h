//
//  MYZSettingCell.h
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/20.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const SettingCellId = @"SettingCellId";

@class MYZSettingItem;

@interface MYZSettingCell : UITableViewCell

@property (nonatomic, strong) MYZSettingItem * itemData;


+ (id)settingCellWithTableView:(UITableView *)tableView;


@end
