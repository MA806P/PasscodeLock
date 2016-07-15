//
//  MYZTabBarController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/13.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZTabBarController.h"
#import "MYZNavigationController.h"
#import "MYZHomeController.h"
#import "MYZMineController.h"

@interface MYZTabBarController ()

@end

@implementation MYZTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MYZHomeController * homeVc = [[MYZHomeController alloc] init];
    homeVc.view.backgroundColor = [UIColor lightGrayColor];
    [self addChildController:homeVc title:@"首页" imageName:@"tab_1"];
    
    MYZMineController * mineVc = [[MYZMineController alloc] init];
    mineVc.view.backgroundColor = [UIColor cyanColor];
    [self addChildController:mineVc title:@"我的" imageName:@"tab_2"];
    
    //self.selectedIndex = 1;
}

//添加子控制器
- (void)addChildController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName
{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    MYZNavigationController * nav = [[MYZNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}



@end
