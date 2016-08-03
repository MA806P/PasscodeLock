//
//  MYZGestureView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/28.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZGestureView.h"
#import "MYZCircleView.h"



CGFloat const CircleViewMarginBorder = 5.0f;
CGFloat const CircleViewMarginNear = 30.0f;

NSInteger const CircleViewBaseTag = 100;


@interface MYZGestureView ()

@property (nonatomic, strong) NSMutableArray * selectCircleArray;

@property (nonatomic, assign) CGPoint currentTouchPoint;

//@property (nonatomic, copy) void(^success)(NSString * gestureCode);
//@property (nonatomic, copy) void(^failure)(NSString * erroMessage);


@end


@implementation MYZGestureView


- (NSMutableArray *)selectCircleArray
{
    if (_selectCircleArray == nil)
    {
        _selectCircleArray = [NSMutableArray array];
    }
    return _selectCircleArray;
}


#pragma mark - initializer

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
    self.backgroundColor = [UIColor clearColor];
    
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
    CGFloat circleWH = (squareWH - (CircleViewMarginBorder+CircleViewMarginNear)*2.0)/3.0;
    
    
    for (int i = 0; i < 9; i++)
    {
        MYZCircleView * circleView = [self viewWithTag:i+CircleViewBaseTag];
        
        NSInteger currentRow = i / 3;
        NSInteger currentColumn = i % 3;
        CGFloat circleX = CircleViewMarginBorder + (CircleViewMarginNear + circleWH) * currentColumn;
        CGFloat circleY = CircleViewMarginBorder + (CircleViewMarginNear + circleWH) * currentRow;
        
        circleView.frame = CGRectMake(circleX, circleY, circleWH, circleWH);
    }
    
}


#pragma mark - draw view

- (void)drawRect:(CGRect)rect
{
    self.clearsContextBeforeDrawing = YES;
    CGContextRef cr = UIGraphicsGetCurrentContext();
    
    //剪切，画线只能在圆外画
    CGContextAddRect(cr, rect);
    for (int i = 0; i < 9; i++)
    {
        MYZCircleView * circleView = [self viewWithTag:i+CircleViewBaseTag];
        CGContextAddEllipseInRect(cr, circleView.frame);
    }
    CGContextEOClip(cr);
    
    
    //画线
    for (int i = 0; i<self.selectCircleArray.count; i++)
    {
        MYZCircleView * circleView = self.selectCircleArray[i];
        CGPoint circleCentre = circleView.center;
        if (i == 0)
        {
            CGContextMoveToPoint(cr, circleCentre.x, circleCentre.y);
        }
        else
        {
            CGContextAddLineToPoint(cr, circleCentre.x, circleCentre.y);
        }
    }
    
    if (self.selectCircleArray.count > 0)
    {
        CGContextAddLineToPoint(cr, self.currentTouchPoint.x, self.currentTouchPoint.y);
    }
    
    CGContextSetLineCap(cr, kCGLineCapRound);
    CGContextSetLineWidth(cr, 6);
    [[UIColor whiteColor] set];
    //渲染
    CGContextStrokePath(cr);
    
}


#pragma mark - Touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self checkCircleViewTouch:touches];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self checkCircleViewTouch:touches];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSMutableString * gestureCode = [NSMutableString string];
    for (MYZCircleView * circleView in self.selectCircleArray)
    {
        [gestureCode appendFormat:@"%ld",circleView.tag - CircleViewBaseTag];
        circleView.circleStatus = CircleViewStatusNormal;
    }
    
    
    if (gestureCode.length > 0 && self.gestureResult != nil)
    {
        self.gestureResult(gestureCode);
    }
    
    [self.selectCircleArray removeAllObjects];
    [self setNeedsDisplay];
}





- (void)checkCircleViewTouch:(NSSet *)touches
{
    UITouch *touch =  [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.currentTouchPoint = point;
    
    for (int i = 0; i < 9; i++)
    {
        MYZCircleView * circleView = [self viewWithTag:i+CircleViewBaseTag];
        
        if(CGRectContainsPoint(circleView.frame, point) && ![self.selectCircleArray containsObject:circleView])
        {
            circleView.circleStatus = CircleViewStatusSelected;
            [self.selectCircleArray addObject:circleView];
            break;
        }
    }
}



@end
