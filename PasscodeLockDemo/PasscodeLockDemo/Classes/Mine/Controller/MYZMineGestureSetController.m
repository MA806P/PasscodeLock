//
//  MYZMineGestureSetController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/8/4.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineGestureSetController.h"
#import "MYZMineGestureController.h"
#import "MYZGestureView.h"
#import "MYZCircleView.h"
#import "MYZGestureShapeView.h"
#import "CALayer+shake.h"


#define SetLabelTextColor CircleNormalColor
NSString * SetLabelText = @"请设置手势密码";
NSString * const SetLabelErrorText = @"前后设置不一致";



@interface MYZMineGestureSetController ()

@property (nonatomic, weak) MYZGestureShapeView * shapeView;

@property (nonatomic, weak) UILabel * infoLabel;
@property (nonatomic, copy) NSString * infoLabelDefaultText;

@property (nonatomic, weak) MYZGestureView * gestureView;

@property (nonatomic, copy) NSString * firstGestureCode;

@end

@implementation MYZMineGestureSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    
    //设置默认值为修改密码的类型，因为点击修改是父类push过来的不方便设置type
    if (!self.gestureSetType)
    {
        self.gestureSetType = GestureSetTypeChange;
    }
    
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat marginTop = 100;
    if (self.gestureSetType == GestureSetTypeInstall)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(resetGesture)];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
     
        //手势缩略图
        CGFloat shapeWH = 40;
        CGFloat shapX = (screenW - shapeWH)*0.5;
        MYZGestureShapeView * shapeView = [[MYZGestureShapeView alloc] initWithFrame:CGRectMake(shapX, marginTop, shapeWH, shapeWH)];
        shapeView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:shapeView];
        self.shapeView = shapeView;
        
        self.infoLabelDefaultText = SetLabelText;
    }
    else if (self.gestureSetType == GestureSetTypeDelete || self.gestureSetType == GestureSetTypeChange)
    {
        self.infoLabelDefaultText = @"请输入原手势密码";
    }
    
    UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, marginTop+CGRectGetHeight(self.shapeView.frame)+5, screenW, 20)];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = [UIFont systemFontOfSize:14];
    infoLabel.textColor = SetLabelTextColor;
    infoLabel.text = self.infoLabelDefaultText;
    [self.view addSubview:infoLabel];
    self.infoLabel = infoLabel;
    
    
    CGFloat gestureViewWH = 260;
    CGFloat gestureViewX = (screenW - gestureViewWH) * 0.5;
    CGFloat gestureViewY = CGRectGetMaxY(self.infoLabel.frame) + 30;
    MYZGestureView * gestureView = [[MYZGestureView alloc] initWithFrame:CGRectMake(gestureViewX, gestureViewY, gestureViewWH, gestureViewWH)];
    __weak typeof(self) weakSelf = self;
    gestureView.gestureResult = ^(NSString * gestureCode){
        
        //NSLog(@" MYZMineGestureSetController -- %@", gestureCode);
        
        //设置手势解锁图案
        if (weakSelf.gestureSetType == GestureSetTypeInstall)
        {
            if (gestureCode.length >= 4)
            {
                if (weakSelf.firstGestureCode == nil)
                {
                    weakSelf.shapeView.gestureCode = gestureCode;
                    weakSelf.firstGestureCode = gestureCode;
                    weakSelf.infoLabel.text = @"再次绘制解锁图案";
                    weakSelf.infoLabel.textColor = CircleNormalColor;
                    
                    //导航栏上的重置按钮
                    [weakSelf.navigationItem.rightBarButtonItem setEnabled:YES];
                    
                    return YES;
                }
                else if ([weakSelf.firstGestureCode isEqualToString:gestureCode])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:gestureCode forKey:GestureCodeKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    if (weakSelf.lockBlock)
                    {
                        weakSelf.lockBlock(YES);
                    }
                    
                    //返回
                    for (UIViewController * vc in weakSelf.navigationController.viewControllers)
                    {
                        if ([vc isKindOfClass:[MYZMineGestureController class]])
                        {
                            [weakSelf.navigationController popToViewController:vc animated:YES];
                        }
                    }
                    return YES;
                }
                else
                {
                    weakSelf.infoLabel.text = SetLabelErrorText;
                    weakSelf.infoLabel.textColor = CircleErrorColor;
                    [weakSelf.infoLabel.layer shake];
                }
            }
            else if (self.firstGestureCode != nil)
            {
                weakSelf.infoLabel.text = SetLabelErrorText;
                weakSelf.infoLabel.textColor = CircleErrorColor;
                [weakSelf.infoLabel.layer shake];
            }
            else if (gestureCode.length < 4)
            {
                weakSelf.infoLabel.text = @"连接至少4个点，请重新设置";
                weakSelf.infoLabel.textColor = CircleErrorColor;
                [weakSelf.infoLabel.layer shake];
            }
            return NO;
        }
        //修改手势密码，修改前先验证原密码
        else if (weakSelf.gestureSetType == GestureSetTypeChange)
        {
            if ([weakSelf verifyGestureCodeWitCode:gestureCode])
            {
                MYZMineGestureSetController * gestureSetVC = [[MYZMineGestureSetController alloc] init];
                gestureSetVC.gestureSetType = GestureSetTypeInstall;
                [[NSUserDefaults standardUserDefaults] setObject:gestureCode forKey:GestureCodeKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [weakSelf.navigationController pushViewController:gestureSetVC animated:YES];
                
                return YES;
            }
            else
            {
                return NO;
            }
            
            
            
        }
        else if (weakSelf.gestureSetType == GestureSetTypeDelete)
        {
            if ([weakSelf verifyGestureCodeWitCode:gestureCode])
            {
                //密码验证成功，回调关闭你手势密码
                if (weakSelf.lockBlock)
                {
                    weakSelf.lockBlock(NO);
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:GestureCodeKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
                return YES;
            }
            else
            {
                return NO;
            }
        }
        
        return NO;
        
    };
    [self.view addSubview:gestureView];
    
}

//验证密码
- (BOOL)verifyGestureCodeWitCode:(NSString *) gestureCode
{
    NSString * saveGestureCode = [[NSUserDefaults standardUserDefaults] objectForKey:GestureCodeKey];
    if ([gestureCode isEqualToString:saveGestureCode])
    {
        return YES;
    }
    else
    {
        [self infoLabelErrorMessage:@"密码错误"];
        return NO;
    }
}

//密码错误提示
- (void)infoLabelErrorMessage:(NSString *)message
{
    __weak typeof(self) weakSelf = self;
    weakSelf.infoLabel.text = message;
    weakSelf.infoLabel.textColor = CircleErrorColor;
    [weakSelf.infoLabel.layer shake];
}

//重置
- (void)resetGesture
{
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    self.shapeView.gestureCode = nil;
    self.firstGestureCode = nil;
    self.infoLabel.text = SetLabelText;
    self.infoLabel.textColor = SetLabelTextColor;
}


//导航栏返回按钮
- (void)back
{
    //设置手势密码，点击返回设置失败
    if (self.gestureSetType == GestureSetTypeInstall && self.lockBlock)
    {
        self.lockBlock(NO);
    }
    //删除手势密码，点击返回删除失败
    else if (self.gestureSetType == GestureSetTypeDelete && self.lockBlock)
    {
        //删除失败手势是锁上的
        self.lockBlock(YES);
    }
    
    [self popViewController];
    
}


- (void)popViewController
{
    for (UIViewController * vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[MYZMineGestureController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}



@end
