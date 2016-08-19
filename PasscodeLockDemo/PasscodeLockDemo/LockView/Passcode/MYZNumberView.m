//
//  MYZNumberView.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/8/18.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZNumberView.h"



@implementation MYZNumberView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef cr = UIGraphicsGetCurrentContext();
    
    CGFloat numberDiameter = MIN(rect.size.width, rect.size.height) - 2.0;
    CGRect numberRect = CGRectMake(1.0, 1.0, numberDiameter, numberDiameter);
    
    CGContextAddEllipseInRect(cr, numberRect);
    CGContextSetLineWidth(cr, 1.0);
    [NumberViewColor set];
    self.numberViewState == NumberViewStateHighlight ? CGContextFillPath(cr) : CGContextStrokePath(cr);
    
    CGFloat textWH = numberDiameter*0.8;
    CGFloat textX = (rect.size.width - textWH) * 0.5;
    CGFloat textY = (rect.size.height - textWH) * 0.5;
    CGRect textRect = CGRectMake(textX, textY, textWH, textWH);
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    UIColor * textColor = [UIColor whiteColor];
    [self.numberText drawInRect:textRect withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:30], NSForegroundColorAttributeName : textColor, NSParagraphStyleAttributeName : style}];
    
}


- (void)setNumberText:(NSString *)numberText
{
    _numberText = numberText;
    
    [self setNeedsDisplay];
}


- (void)setNumberViewState:(NumberViewState)numberViewState
{
    _numberViewState = numberViewState;
    
    [self setNeedsDisplay];
}



@end
