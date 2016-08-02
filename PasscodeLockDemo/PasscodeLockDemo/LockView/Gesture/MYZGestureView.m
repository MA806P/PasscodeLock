//
//  MYZGestureView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/28.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZGestureView.h"
#import "MYZCircleView.h"


CGFloat const CircleMarginBorder = 5.0f;
CGFloat const CircleMarginNear = 30.0f;

NSInteger const CircleViewBaseTag = 100;


@implementation MYZGestureView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubviews];
    }
    return self;
}

//子视图初始化
- (void)initSubviews
{
    self.backgroundColor = [UIColor blackColor];
    
    for (int i=0; i<9; i++)
    {
        MYZCircleView * circle = [[MYZCircleView alloc] init];
        circle.tag = i+CircleViewBaseTag;
        [self addSubview:circle];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //手势解锁视图的大小
    CGFloat squareWH = MIN(self.frame.size.width, self.frame.size.height);
    //小圆的大小
    CGFloat circleWH = (squareWH - (CircleMarginBorder+CircleMarginNear)*2.0)/3.0;
    
    
    for (int i = 0; i < 9; i++)
    {
        MYZCircleView * circleView = [self viewWithTag:i+CircleViewBaseTag];
        
        NSInteger currentRow = i / 3;
        NSInteger currentColumn = i % 3;
        CGFloat circleX = CircleMarginBorder + (CircleMarginNear + circleWH) * currentRow;
        CGFloat circleY = CircleMarginBorder + (CircleMarginNear + circleWH) * currentColumn;
        
        circleView.frame = CGRectMake(circleX, circleY, circleWH, circleWH);
    }
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for (int i = 0; i < 9; i++)
    {
        MYZCircleView * circleView = [self viewWithTag:i+CircleViewBaseTag];
        
        if(CGRectContainsPoint(circleView.frame, touchPoint))
        {
            
        }
        
    }
    
    
}






@end
