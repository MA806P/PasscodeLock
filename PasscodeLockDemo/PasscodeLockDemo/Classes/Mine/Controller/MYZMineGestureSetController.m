//
//  MYZMineGestureSetController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/8/4.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineGestureSetController.h"
#import "MYZGestureView.h"
#import "MYZGestureShapeView.h"

@interface MYZMineGestureSetController ()

@property (nonatomic, weak) MYZGestureShapeView * shapeView;

@property (nonatomic, weak) UILabel * infoLabel;

@property (nonatomic, weak) MYZGestureView * gestureView;

@property (nonatomic, copy) NSString * firstGestureCode;

@end

@implementation MYZMineGestureSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回了" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat marginTop = 100;
    if (self.gestureSetType == GestureSetTypeInstall)
    {
        CGFloat shapeWH = 40;
        CGFloat shapX = (screenW - shapeWH)*0.5;
        MYZGestureShapeView * shapeView = [[MYZGestureShapeView alloc] initWithFrame:CGRectMake(shapX, marginTop, shapeWH, shapeWH)];
        shapeView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:shapeView];
        self.shapeView = shapeView;
    }
    
    UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, marginTop+CGRectGetHeight(self.shapeView.frame)+5, screenW, 20)];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = [UIFont systemFontOfSize:14];
    infoLabel.text = @"请设置手势密码";
    [self.view addSubview:infoLabel];
    self.infoLabel = infoLabel;
    
    
    CGFloat gestureViewWH = 300;
    CGFloat gestureViewX = (screenW - gestureViewWH) * 0.5;
    CGFloat gestureViewY = CGRectGetMaxY(self.infoLabel.frame) + 30;
    MYZGestureView * gestureView = [[MYZGestureView alloc] initWithFrame:CGRectMake(gestureViewX, gestureViewY, gestureViewWH, gestureViewWH)];
    __weak typeof(self) weakSelf = self;
    gestureView.gestureResult = ^(NSString * gestureCode){
        NSLog(@" MYZMineGestureSetController -- %@", gestureCode);
        
        if (weakSelf.gestureSetType == GestureSetTypeInstall && gestureCode.length > 3)
        {
            weakSelf.shapeView.gestureCode = gestureCode;
            
            if (self.firstGestureCode == nil)
            {
                self.firstGestureCode = gestureCode;
                weakSelf.infoLabel.text = @"再次绘制解锁图案";
            }
            else if ([self.firstGestureCode isEqualToString:gestureCode])
            {
                [[NSUserDefaults standardUserDefaults] setObject:gestureCode forKey:GestureCodeKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if (weakSelf.lockBlock)
                {
                    weakSelf.lockBlock(YES);
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                weakSelf.infoLabel.text = @"前后设置不一致";
            }
        }
        else if (weakSelf.gestureSetType == GestureSetTypeInstall && self.firstGestureCode != nil)
        {
            weakSelf.infoLabel.text = @"前后设置不一致";
        }
        else if (weakSelf.gestureSetType == GestureSetTypeInstall && gestureCode.length < 4)
        {
            weakSelf.infoLabel.text = @"连接至少4个点，请重新设置";
        }
        
    };
    [self.view addSubview:gestureView];
    
}



- (void)back
{
    if (self.lockBlock)
    {
        self.lockBlock(NO);
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
