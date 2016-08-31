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
    
    CGFloat lineWidth = 1.0;
    CGFloat numberDiameter = MIN(rect.size.width, rect.size.height) - lineWidth*2.0;
    CGFloat numberX = (rect.size.width - numberDiameter) * 0.5;
    CGFloat numberY = (rect.size.height - numberDiameter) * 0.5;
    CGRect numberRect = CGRectMake(numberX, numberY, numberDiameter, numberDiameter);
    
    CGContextAddEllipseInRect(cr, numberRect);
    CGContextSetLineWidth(cr, lineWidth);
    
    if (self.numberViewState == NumberViewStateHighlight)
    {
        [[UIColor colorWithWhite:0.800 alpha:1.000] set];
        CGContextFillPath(cr);
    }
    else
    {
        [NumberViewColor set];
        CGContextStrokePath(cr);
    }

    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    UIColor * textColor = NumberViewColor;
    
    NSDictionary * attributeDic = @{NSFontAttributeName : [UIFont systemFontOfSize:30 weight:UIFontWeightThin], NSForegroundColorAttributeName : textColor, NSParagraphStyleAttributeName : style};
    
    //计算数字居中
    CGSize textSize = [self.numberText boundingRectWithSize:rect.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil].size;
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    CGFloat textX = (rect.size.width - textW) * 0.5;
    CGFloat textY = (rect.size.height - textH) * 0.5;
    CGRect textRect = CGRectMake(textX, textY, textW, textH);
    
    [self.numberText drawInRect:textRect withAttributes:attributeDic];
    
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
