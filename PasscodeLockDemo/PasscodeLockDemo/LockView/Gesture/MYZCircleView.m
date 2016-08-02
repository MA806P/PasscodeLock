//
//  MYZCircleView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/8/1.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZCircleView.h"

#define CircleNormalBorderColor [UIColor whiteColor];

@implementation MYZCircleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef cr = UIGraphicsGetCurrentContext();
    
    CGFloat circleDiameter = MIN(rect.size.width, rect.size.height) - 2;
    CGRect circleInRect = CGRectMake(1, 1, circleDiameter, circleDiameter);
    CGContextAddEllipseInRect(cr, circleInRect);
    CGContextSetLineWidth(cr, 1.0);
    [[UIColor whiteColor] set];
    
    CGContextStrokePath(cr);
    
    CGFloat filledCircleDiameter = circleDiameter * 0.4;
    CGFloat filledCircleX = (rect.size.width - filledCircleDiameter)*0.5;
    CGFloat filledCircleY = (rect.size.height - filledCircleDiameter)*0.5;
    CGContextAddEllipseInRect(cr, CGRectMake(filledCircleX, filledCircleY, filledCircleDiameter, filledCircleDiameter));
    
    
}


@end
