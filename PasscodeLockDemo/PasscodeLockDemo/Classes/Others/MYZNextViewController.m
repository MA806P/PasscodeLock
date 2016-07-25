//
//  MYZNextViewController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/13.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZNextViewController.h"

@interface MYZNextViewController ()

@end

@implementation MYZNextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 60)];
    btn.tag = 1001;
    [btn setTitle:@"设置密码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 60)];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
}


- (void)close:(UIButton *)btn
{
    __weak typeof(self) weakSelf = self;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (btn.tag == 1001 && weakSelf.lockBlock) {
            weakSelf.lockBlock(YES);
        }
        else
        {
            weakSelf.lockBlock(NO);
        }
        
    }];
}

@end
