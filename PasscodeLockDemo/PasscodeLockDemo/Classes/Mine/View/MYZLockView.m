//
//  MYZLockView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/25.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZLockView.h"

@implementation MYZLockView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor colorWithWhite:0.667 alpha:1.0];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closse)];
        [self addGestureRecognizer:tap];
    }
    return self;
}



- (void)closse
{
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.8 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
    
}


@end
