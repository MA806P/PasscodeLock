//
//  MYZCircleView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/8/1.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZCircleView.h"

@implementation MYZCircleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef cr = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(cr, rect);
    CGContextSetLineWidth(cr, 1.0);
    [[UIColor whiteColor] set];
    
    CGContextStrokePath(cr);
    
}


@end
