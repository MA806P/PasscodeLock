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
        CGFloat circleX = CircleMarginBorder + (CircleMarginNear + circleWH) * currentColumn;
        CGFloat circleY = CircleMarginBorder + (CircleMarginNear + circleWH) * currentRow;
        
        circleView.frame = CGRectMake(circleX, circleY, circleWH, circleWH);
    }
    
}

//- (void)gestureOperatedSuccess:(void (^)(NSString *))success failure:(void (^)(NSString *))failure
//{
//    self.success = success;
//    self.failure = failure;
//}

#pragma mark - draw view

- (void)drawRect:(CGRect)rect
{
    if (self.selectCircleArray.count <= 0) { return; }
    
    MYZCircleView * circleView = [self.selectCircleArray firstObject];
    CGPoint circleCentre = circleView.center;
    CGContextRef cr = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(cr, circleCentre.x, circleCentre.y);
    CGContextAddLineToPoint(cr, self.currentTouchPoint.x, self.currentTouchPoint.y);
    
    CGContextSetLineCap(cr, kCGLineCapRound); //线移动时的形状
    CGContextSetLineJoin(cr, kCGLineJoinRound); //线段转角处的形状
    CGContextSetLineWidth(cr, 6);
    [[UIColor whiteColor] set];
    //渲染
    CGContextStrokePath(cr);
    
}


#pragma mark - Touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.selectCircleArray removeAllObjects];
    
    
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    self.currentTouchPoint = touchPoint;
    [self checkCircleViewTouchWithPoint:touchPoint];
    
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    self.currentTouchPoint = touchPoint;
    [self checkCircleViewTouchWithPoint:touchPoint];
    
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
    
    
}


- (void)checkCircleViewTouchWithPoint:(CGPoint)point
{
    for (int i = 0; i < 9; i++)
    {
        MYZCircleView * circleView = [self viewWithTag:i+CircleViewBaseTag];
        
        if(CGRectContainsPoint(circleView.frame, point) && ![self.selectCircleArray containsObject:circleView])
        {
            circleView.circleStatus = CircleViewStatusSelected;
            [self.selectCircleArray addObject:circleView];
        }
    }
    
    [self setNeedsDisplay];
}



@end
