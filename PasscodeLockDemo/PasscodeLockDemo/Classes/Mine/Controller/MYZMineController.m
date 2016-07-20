//
//  MYZMineController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/13.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineController.h"
#import "MYZSettingGroup.h"
#import "MYZSettingPushItem.h"

@interface MYZMineController ()

@end

@implementation MYZMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 120)];
    headView.backgroundColor = [UIColor clearColor];
    UIView * headContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    headContentView.backgroundColor = [UIColor whiteColor];
    UIImageView * headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 60, 60)];
    headImgView.image = [UIImage imageNamed:@"head"];
    headImgView.layer.cornerRadius = 30;
    headImgView.layer.masksToBounds = YES;
    [headContentView addSubview:headImgView];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgView.frame)+10, 0, 100, 100)];
    label.text = @"MA806P";
    [headContentView addSubview:label];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewHeadViewTap)];
    [headContentView addGestureRecognizer:tap];
    [headView addSubview:headContentView];
    
    self.tableView.tableHeaderView = headView;
    
    
    //MYZSettingPushItem * item = [MYZSettingPushItem settingItemWithIconName:@"lock_icon" andLabelText:@"安全设置"];
    MYZSettingPushItem * item = [MYZSettingPushItem settingPushItemWithIconName:@"lock_icon" andLabelText:@"安全设置" andNextClass:[UIViewController class]];
    
    MYZSettingGroup * group = [[MYZSettingGroup alloc] init];
    //group.headerTitle = @"header title test";
    //group.footerTitle = @"footer title test";
    group.items = @[item];
    
    self.dataSources = @[group];
    
}



- (void)tableViewHeadViewTap
{
    UIViewController * vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor lightGrayColor];
    NSData * gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"" ofType:@"gif"]];
    UIWebView * webView = [[UIWebView alloc] initWithFrame:vc.view.bounds];
    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL new]];
    [vc.view addSubview:webView];
    
    [self.navigationController pushViewController:vc animated:YES];
}




@end
