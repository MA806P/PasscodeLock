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

@property (nonatomic, strong) UIView * firstView;

@end

@implementation MYZTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MYZHomeController * homeVc = [[MYZHomeController alloc] init];
    [self addChildController:homeVc title:@"首页" imageName:@"tab_1"];
    
    MYZMineController * mineVc = [[MYZMineController alloc] init];
    [self addChildController:mineVc title:@"我的" imageName:@"tab_2"];
    self.selectedIndex = 1;
    
    self.firstView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.firstView.backgroundColor =[UIColor colorWithWhite:0.667 alpha:1.0];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closse)];
    [self.firstView addGestureRecognizer:tap];
    [self.view addSubview:self.firstView];
}

- (void)closse
{
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.8 animations:^{
        weakSelf.firstView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.firstView removeFromSuperview];
    }];
    
    
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
