//
//  MYZMineController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/13.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineController.h"
#import "MYZMineLockTypeController.h"

#import <Photos/Photos.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>


//typedef enum {
//    kCLAuthorizationStatusNotDetermined = 0, // 用户尚未做出选择这个应用程序的问候
//    kCLAuthorizationStatusRestricted,        // 此应用程序没有被授权访问的照片数据。可能是家长控制权限
//    kCLAuthorizationStatusDenied,            // 用户已经明确否认了这一照片数据的应用程序访问
//    kCLAuthorizationStatusAuthorized         // 用户已经授权应用访问照片数据
//} CLAuthorizationStatus;


@interface MYZMineController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) UIImageView * headImgView;

@end

@implementation MYZMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 120)];
    headView.backgroundColor = [UIColor clearColor];
    UIView * headContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    headContentView.backgroundColor = [UIColor whiteColor];
    UIImageView * headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 60, 60)];
    headImgView.image = [UIImage imageNamed:@"head"];
    headImgView.layer.cornerRadius = 30;
    headImgView.layer.masksToBounds = YES;
    headImgView.userInteractionEnabled = YES;
    [headContentView addSubview:headImgView];
    self.headImgView = headImgView;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgView.frame)+10, 0, 100, 100)];
    label.text = @"MA806P";
    [headContentView addSubview:label];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewHeadViewTap)];
    [headContentView addGestureRecognizer:tap];
    [headView addSubview:headContentView];
    
    self.tableView.tableHeaderView = headView;
    
    
    //MYZSettingPushItem * item = [MYZSettingPushItem settingItemWithIconName:@"lock_icon" andLabelText:@"安全设置"];
    MYZSettingPushItem * item = [MYZSettingPushItem settingPushItemWithIconName:@"lock_icon" andLabelText:@"安全设置" andNextClass:[MYZMineLockTypeController class]];
    
    MYZSettingGroup * group = [[MYZSettingGroup alloc] init];
    group.items = @[item];
    
    self.dataSources = @[group];
    
}


#pragma mark - Imagepicker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        self.headImgView.image = image;
    }];
    
}

- (void)tableViewHeadViewTap
{
    UIViewController * vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    vc.automaticallyAdjustsScrollViewInsets = NO;
    NSData * gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"00" ofType:@"gif"]];
    CGFloat gifWH = 200;
    CGFloat gifY = ([UIScreen mainScreen].bounds.size.height-64-gifWH)*0.5;
    CGFloat gifX = ([UIScreen mainScreen].bounds.size.width-gifWH)*0.5;
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(gifX, gifY, gifWH, gifWH)];
    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL new]];
    webView.scrollView.bounces = NO;
    webView.scalesPageToFit = YES;
    [vc.view addSubview:webView];
    
    [self.navigationController pushViewController:vc animated:YES];
}




@end
