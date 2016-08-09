//
//  MYZLockView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/25.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZLockView.h"
#import "MYZGestureView.h"
#import "MYZPasscodeView.h"

@interface MYZLockView ()

@property (nonatomic, weak) MYZGestureView * gestureView;

@property (nonatomic, weak) MYZPasscodeView * passcodeView;

@end

@implementation MYZLockView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor colorWithWhite:0.667 alpha:1.0];
    }
    return self;
}


- (void)setShowGestureViewBool:(BOOL)showGestureViewBool
{
    _showGestureViewBool = showGestureViewBool;
    
    if (showGestureViewBool)
    {
        __weak typeof(self) weakSelf = self;
        MYZGestureView * gestureView = [[MYZGestureView alloc] init];
        gestureView.gestureResult = ^(NSString * gestureCode){
            
            
            NSString * saveGestureCode = [[NSUserDefaults standardUserDefaults] objectForKey:GestureCodeKey];
            NSLog(@" MYZLockView -- %@ == old %@", gestureCode, saveGestureCode);
            if ([gestureCode isEqualToString:saveGestureCode])
            {
                [weakSelf closse];
            }
            
        };
        [self addSubview:gestureView];
        self.gestureView = gestureView;
    }
    
}


- (void)setShowPasscodeViewBool:(BOOL)showPasscodeViewBool
{
    _showPasscodeViewBool = showPasscodeViewBool;
    
    if (showPasscodeViewBool)
    {
        MYZPasscodeView * passcodeView = [[MYZPasscodeView alloc] init];
        [self addSubview:passcodeView];
        self.passcodeView = passcodeView;
    }
    
}





- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    if (self.showGestureViewBool)
    {
        self.gestureView.frame = CGRectMake(20, 20, 280, 280);
    }
    else if (self.showPasscodeViewBool)
    {
        self.passcodeView.frame = CGRectMake(10, 10, 100, 100);
    }
    
}




- (void)closse
{
    [UIView animateWithDuration:0.8 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


@end
