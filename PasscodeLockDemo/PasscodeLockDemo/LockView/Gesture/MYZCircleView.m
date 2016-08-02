//
//  MYZCircleView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/8/1.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZCircleView.h"

#define CircleNormalColor [UIColor whiteColor];
#define CircleSelectedColor [UIColor blueColor];
#define CircleErrorColor [UIColor redColor];

@interface MYZCircleView ()

@property (nonatomic, strong) UIColor * circleColor;

@end

@implementation MYZCircleView




- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.circleStatus = CircleViewStatusNormal;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef cr = UIGraphicsGetCurrentContext();
    
    CGFloat circleDiameter = MIN(rect.size.width, rect.size.height) - 2;
    CGRect circleInRect = CGRectMake(1, 1, circleDiameter, circleDiameter);
    CGContextAddEllipseInRect(cr, circleInRect);
    CGContextSetLineWidth(cr, 1.0);
    [self.circleColor set];
    CGContextStrokePath(cr);
    
    
    if (self.circleStatus != CircleViewStatusNormal)
    {
        CGFloat filledCircleDiameter = circleDiameter * 0.4;
        CGFloat filledCircleX = (rect.size.width - filledCircleDiameter)*0.5;
        CGFloat filledCircleY = (rect.size.height - filledCircleDiameter)*0.5;
        CGContextAddEllipseInRect(cr, CGRectMake(filledCircleX, filledCircleY, filledCircleDiameter, filledCircleDiameter));
        [self.circleColor set];
        CGContextFillPath(cr);
    }
    
    
}


- (void)setCircleStatus:(CircleViewStatus)circleStatus
{
    _circleStatus = circleStatus;
    
    if (_circleStatus == CircleViewStatusNormal)
    {
        self.circleColor = CircleNormalColor;
    }
    else if (_circleStatus == CircleViewStatusSelected)
    {
        self.circleColor = CircleSelectedColor;
    }
    else if (_circleStatus == CircleViewStatusError)
    {
        self.circleColor = CircleErrorColor;
    }
    
    [self setNeedsDisplay];
}




@end
