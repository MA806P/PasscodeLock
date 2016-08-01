//
//  MYZGestureView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/28.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZGestureView.h"
#import "MYZCircleView.h"

@implementation MYZGestureView


-(instancetype)init
{
    if (self = [super init])
    {
        [self initSubviews];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews
{
    self.backgroundColor = [UIColor blackColor];
    
    
    for (int i=0; i<9; i++)
    {
        MYZCircleView * circle = [[MYZCircleView alloc] init];
        circle.tag = i+100;
        [self addSubview:circle];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat marginBorder = 5;
    CGFloat marginNear = 8;
    
    CGFloat squareWH = MIN(self.frame.size.width, self.frame.size.height);
    CGFloat circleWH = (squareWH - (marginBorder+marginNear)*2)/3.0;
    
    
    for (int i = 0; i < 9; i++)
    {
        
        MYZCircleView * circleView = [self viewWithTag:i+100];
        
        NSInteger currentRow = i / 3;
        NSInteger currentColumn = i % 3;
        CGFloat circleX = marginBorder + (marginNear + circleWH) * currentRow;
        CGFloat circleY = marginBorder + (marginNear + circleWH) * currentColumn;
        
        circleView.frame = CGRectMake(circleX, circleY, circleWH, circleWH);
    }
    
}



@end
