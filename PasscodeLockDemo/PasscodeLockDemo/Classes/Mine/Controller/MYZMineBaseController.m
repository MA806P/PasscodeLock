//
//  MYZMineBaseController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/20.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineBaseController.h"
#import "MYZSettingGroup.h"
#import "MYZSettingItem.h"
#import "MYZSettingPushItem.h"
#import "MYZSettingCheckItem.h"
#import "MYZSettingSwitchItem.h"

#import "MYZSettingCell.h"

@interface MYZMineBaseController ()



@end

@implementation MYZMineBaseController


- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[MYZSettingCell class] forCellReuseIdentifier:SettingCellId];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MYZSettingGroup * group = self.dataSources[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MYZSettingCell * cell = [MYZSettingCell settingCellWithTableView:tableView];
    
    MYZSettingGroup * group = self.dataSources[indexPath.section];
    cell.itemData = group.items[indexPath.row];
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MYZSettingGroup * group = self.dataSources[indexPath.section];
    MYZSettingItem * item = group.items[indexPath.row];
    
    if ([item isKindOfClass:[MYZSettingPushItem class]])
    {
        Class vcClass = [(MYZSettingPushItem *)item nextControllerClass];
        if (vcClass) {
            [self.navigationController pushViewController:[[vcClass alloc] init] animated:YES];
        }
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MYZSettingGroup * group = self.dataSources[section];
    return group.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    MYZSettingGroup * group = self.dataSources[section];
    return group.footerTitle;
}


@end
