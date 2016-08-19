//
//  MYZPasscodeView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/28.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZPasscodeView.h"
#import "MYZNumberView.h"

NSInteger const NumberViewBaseTag = 77;


@interface MYZPasscodeView ()

@property (nonatomic, weak) UIButton * fingerprintBtn;

@property (nonatomic, weak) UIButton * deleteBtn;

@property (nonatomic, strong) NSMutableArray * selectNumberArray;

@end



@implementation MYZPasscodeView


- (NSMutableArray *)selectNumberArray
{
    if (_selectNumberArray == nil)
    {
        _selectNumberArray = [NSMutableArray array];
    }
    return _selectNumberArray;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubviews];
    }
    return self;
}



- (void)initSubviews
{
    //数字按钮
    for (int i=0; i<10; i++)
    {
        MYZNumberView * numberView = [[MYZNumberView alloc] init];
        numberView.numberText = [NSString stringWithFormat:@"%d",i];
        numberView.tag = i + NumberViewBaseTag;
        [self addSubview:numberView];
    }
    
    //指纹按钮
    UIButton * fingerprintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fingerprintBtn.backgroundColor = [UIColor brownColor];
    [self addSubview:fingerprintBtn];
    self.fingerprintBtn = fingerprintBtn;
    
    //删除按钮
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:NumberViewColor forState:UIControlStateNormal];
    [self addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat superViewW = self.frame.size.width;
    
    CGFloat marginTop = 0.0;
    
    CGFloat marginRL = 40.0;
    CGFloat marginRow = 10.0;
    CGFloat marginColumn = 24.0;
    
    NSInteger rows = 4;
    NSInteger columns = 3;
    
    CGFloat numberWH = (superViewW - marginRL*2.0 - marginColumn*(columns-1))/columns;
    
    
    for (int i = 1; i < columns * rows + 1; i++)
    {
        NSInteger currentRow = (i-1)/columns;
        NSInteger currentColumn = (i-1)%columns;
        
        CGFloat numberX = marginRL + (marginColumn + numberWH) * currentColumn;
        CGFloat numberY = marginTop + (marginRow + numberWH) * currentRow;
        
        CGRect subviewFrame = CGRectMake(numberX, numberY, numberWH, numberWH);
        
        if (i == 10)
        {
            self.fingerprintBtn.frame = subviewFrame;
            continue;
        }
        else if (i == 11)
        {
            MYZNumberView * numberView = [self viewWithTag:NumberViewBaseTag];
            numberView.frame = subviewFrame;
            continue;
        }
        else if (i == 12)
        {
            self.deleteBtn.frame = subviewFrame;
            continue;
        }
        
        
        MYZNumberView * numberView = [self viewWithTag:i+NumberViewBaseTag];
        numberView.frame = subviewFrame;
        
    }
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for (int i = 0; i < 10; i++)
    {
        MYZNumberView * numberView = [self viewWithTag:i+NumberViewBaseTag];
        
        if (CGRectContainsPoint(numberView.frame, touchPoint))
        {
            numberView.numberViewState = NumberViewStateHighlight;
            [self.selectNumberArray addObject:numberView];
        }
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for (MYZNumberView * numberView in self.selectNumberArray)
    {
        if (!CGRectContainsPoint(numberView.frame, touchPoint) && numberView.numberViewState == NumberViewStateHighlight)
        {
            numberView.numberViewState = NumberViewStateNormal;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (int i = 0; i < 10; i++)
    {
        MYZNumberView * numberView = [self viewWithTag:i+NumberViewBaseTag];
        if (numberView.numberViewState == NumberViewStateHighlight)
        {
            numberView.numberViewState = NumberViewStateNormal;
        }
    }
}





@end
