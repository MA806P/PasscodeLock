//
//  MYZNumberView.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/8/18.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZNumberView.h"

#define NumberBorderColor [UIColor grayColor]

@implementation MYZNumberView


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef cr = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(cr, rect);
    CGContextSetLineWidth(cr, 1.0);
    [NumberBorderColor set];
    CGContextStrokePath(cr);
    
    [self.numberText drawInRect:rect withAttributes:@{}];
    
}


@end
