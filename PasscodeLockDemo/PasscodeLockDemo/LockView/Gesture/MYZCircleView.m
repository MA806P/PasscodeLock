//
//  MYZCircleView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/8/1.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZCircleView.h"


//外空心圆边界宽度
CGFloat const circleBorderWidth = 1.0f;
//内部的实心圆所占外圆的比例大小
CGFloat const circleRatio = 0.4f;



@interface MYZCircleView ()

@property (nonatomic, strong) UIColor * circleColor;

@end

@implementation MYZCircleView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.circleStatus = GestureViewStatusNormal;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef cr = UIGraphicsGetCurrentContext();
    CGContextClearRect(cr, rect);
    
    CGFloat circleDiameter = MIN(rect.size.width, rect.size.height) - circleBorderWidth * 2.0;
    CGRect circleInRect = CGRectMake(circleBorderWidth, circleBorderWidth, circleDiameter, circleDiameter);
    CGContextAddEllipseInRect(cr, circleInRect);
    CGContextSetLineWidth(cr, circleBorderWidth);
    [self.circleColor set];
    CGContextStrokePath(cr);
    
    
    if (self.circleStatus != GestureViewStatusNormal)
    {
        CGFloat filledCircleDiameter = circleDiameter * circleRatio;
        CGFloat filledCircleX = (rect.size.width - filledCircleDiameter)*0.5;
        CGFloat filledCircleY = (rect.size.height - filledCircleDiameter)*0.5;
        CGContextAddEllipseInRect(cr, CGRectMake(filledCircleX, filledCircleY, filledCircleDiameter, filledCircleDiameter));
        [self.circleColor set];
        CGContextFillPath(cr);
    }
    
    
}


- (void)setCircleStatus:(GestureViewStatus)circleStatus
{
    _circleStatus = circleStatus;
    
    if (_circleStatus == GestureViewStatusNormal)
    {
        self.circleColor = CircleNormalColor;
    }
    else if (_circleStatus == GestureViewStatusSelected)
    {
        self.circleColor = CircleSelectedColor;
    }
    else if (_circleStatus == GestureViewStatusError)
    {
        self.circleColor = CircleErrorColor;
    }
    
    [self setNeedsDisplay];
}




@end
