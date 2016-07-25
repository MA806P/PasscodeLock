//
//  MYZMineGestureController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/21.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineGestureController.h"
#import "MYZNextViewController.h"

NSString * const item1LabelText = @"手势密码";
NSString * const item2LabelText = @"显示手势轨迹";


@interface MYZMineGestureController ()

@property (nonatomic, strong) MYZSettingSwitchItem * item1;

@end

@implementation MYZMineGestureController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势";
    
    
    self.item1 = [MYZSettingSwitchItem settingItemWithIconName:nil andLabelText:item1LabelText];
    BOOL isSwitchOn = [[NSUserDefaults standardUserDefaults] boolForKey:item1LabelText];
    self.item1.switchOn = isSwitchOn;
    [self.item1 addObserver:self forKeyPath:@"switchOn" options:NSKeyValueObservingOptionNew context:nil];
    [self resetDatasourceArray:isSwitchOn];
    
    
}


- (void)resetDatasourceArray:(BOOL)isSwitchOn
{
    self.dataSources = nil;
    
    if (isSwitchOn)
    {
        MYZSettingSwitchItem * item2 = [MYZSettingSwitchItem settingItemWithIconName:nil andLabelText:item2LabelText];
        item2.switchOn = [[NSUserDefaults standardUserDefaults] boolForKey:item2LabelText];
        MYZSettingGroup * group1 = [[MYZSettingGroup alloc] init];
        group1.items = @[self.item1, item2];
        
        MYZSettingPushItem * item3 = [MYZSettingPushItem settingPushItemWithIconName:nil andLabelText:@"修改手势密码" andNextClass:[UIViewController class]];
        MYZSettingGroup * group2 = [[MYZSettingGroup alloc] init];
        group2.items = @[item3];
        
        self.dataSources = @[group1, group2];
    }
    else
    {
        MYZSettingGroup * group1 = [[MYZSettingGroup alloc] init];
        group1.items = @[self.item1];
        self.dataSources = @[group1];
    }

    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    //NSLog(@" %@ %@  %@",keyPath, object, [change objectForKey:NSKeyValueChangeNewKey]);
    //switchOn <MYZSettingSwitchItem: 0x7beb6150>  1
    
    MYZSettingSwitchItem * item = (MYZSettingSwitchItem *)object;
    
    MYZNextViewController * nvc = [[MYZNextViewController alloc] init];
    [self presentViewController:nvc animated:YES completion:nil];
    
    nvc.lockBlock = ^(BOOL locked){
        [[NSUserDefaults standardUserDefaults] setBool:locked forKey:item.labelText];
        if (locked) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item2LabelText];
        }
        item.switchOn = locked;
        [self resetDatasourceArray:locked];
    };
    [self.tableView reloadData];
    
}



- (void)dealloc
{
    [self.item1 removeObserver:self forKeyPath:@"switchOn"];
}



@end
