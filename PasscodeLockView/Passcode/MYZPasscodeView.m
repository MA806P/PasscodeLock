//
//  MYZPasscodeView.m
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/28.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZPasscodeView.h"
#import "MYZNumberView.h"
#import "MYZPasscodeInfoView.h"
#import "CALayer+shake.h"

#import <LocalAuthentication/LocalAuthentication.h>

/** 设置密码几位数 */
NSInteger const PasscodeCount = 4;

NSInteger const NumberViewBaseTag = 77;


@interface MYZPasscodeView ()

@property (nonatomic, weak) MYZPasscodeInfoView * infoView;

@property (nonatomic, weak) UIButton * fingerprintBtn;

@property (nonatomic, weak) UIButton * deleteBtn;

@property (nonatomic, strong) NSMutableArray * selectNumberArray;

@end



@implementation MYZPasscodeView

#pragma mark - lazy

- (NSMutableArray *)selectNumberArray
{
    if (_selectNumberArray == nil)
    {
        _selectNumberArray = [NSMutableArray array];
    }
    return _selectNumberArray;
}


#pragma mark - initializer

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
    //输入密码的数量指示视图
    MYZPasscodeInfoView * infoView = [[MYZPasscodeInfoView alloc] init];
    [self addSubview:infoView];
    self.infoView = infoView;
    
    //数字按钮
    for (int i=0; i<10; i++)
    {
        MYZNumberView * numberView = [[MYZNumberView alloc] init];
        numberView.numberText = [NSString stringWithFormat:@"%d",i];
        numberView.tag = i + NumberViewBaseTag;
        [self addSubview:numberView];
    }
    
    
    //判断是否支持指纹识别, 需要导入库
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        //本地验证对象上下文
        LAContext *context = [LAContext new];
        
        //Evaluate: 评估  Policy: 策略,方针
        //LAPolicyDeviceOwnerAuthenticationWithBiometrics: 允许设备拥有者使用生物识别技术
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil])
        {
            //指纹按钮
            UIButton * fingerprintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            fingerprintBtn.contentMode = UIViewContentModeCenter;
            [fingerprintBtn setImage:[UIImage imageNamed:@"fingerprint"] forState:UIControlStateNormal];
            [fingerprintBtn addTarget:self action:@selector(showFingerprintTouch) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:fingerprintBtn];
            self.fingerprintBtn = fingerprintBtn;
        }
    
    }
    
    
    
    
    
    //删除按钮
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:NumberViewColor forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor colorWithWhite:0.702 alpha:1.000] forState:UIControlStateHighlighted];
    [deleteBtn addTarget:self action:@selector(deleteBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    
}






- (void)setHideFingerprintBtn:(BOOL)hideFingerprintBtn
{
    _hideFingerprintBtn = hideFingerprintBtn;
    if (self.fingerprintBtn)
    {
        self.fingerprintBtn.hidden = hideFingerprintBtn;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat superViewW = self.frame.size.width;
    CGFloat superViewH = self.frame.size.height;
    
    self.infoView.frame = CGRectMake(0, 0, superViewW, 30);
    
    CGFloat marginTop = 20.0 + CGRectGetMaxY(self.infoView.frame);
    CGFloat marginRow = 15.0;
    CGFloat marginColumn = 24.0;
    
    NSInteger rows = 4;
    NSInteger columns = 3;
    
    CGFloat numberW = (superViewW - marginColumn*(columns-1))/columns;
    CGFloat numberH = (superViewH - marginTop - marginRow*(rows-1))/rows;
    
    for (int i = 1; i < columns * rows + 1; i++)
    {
        NSInteger currentRow = (i-1)/columns;
        NSInteger currentColumn = (i-1)%columns;
        
        CGFloat numberX = (marginColumn + numberW) * currentColumn;
        CGFloat numberY = marginTop + (marginRow + numberH) * currentRow;
        
        CGRect subviewFrame = CGRectMake(numberX, numberY, numberW, numberH);
        
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
        else if (i == 12 && self.deleteBtn != nil)
        {
            self.deleteBtn.frame = subviewFrame;
            continue;
        }
        
        
        MYZNumberView * numberView = [self viewWithTag:i+NumberViewBaseTag];
        numberView.frame = subviewFrame;
        
    }
    
}


#pragma mark - touch event

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
    
    self.infoView.infoCount = self.selectNumberArray.count;
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
    
    
    if (self.selectNumberArray.count == PasscodeCount)
    {
        NSMutableString * passcodeStr = [NSMutableString string];
        for (MYZNumberView * numberView in self.selectNumberArray)
        {
            NSInteger codeInt = numberView.tag - NumberViewBaseTag;
            [passcodeStr appendString:[NSString stringWithFormat:@"%ld",(long)codeInt]];
        }
        
        BOOL isRight = self.PasscodeResult(passcodeStr);
        if (!isRight)
        {
            [self.infoView.layer shake];
        }
        
        self.infoView.infoCount = 0;
        [self.selectNumberArray removeAllObjects];
    }
    
}


//删除按钮
- (void)deleteBtnTouch
{
    [self.selectNumberArray removeLastObject];
    self.infoView.infoCount = self.selectNumberArray.count;
}


//指纹按钮
- (void)showFingerprintTouch
{
    
    LAContext *context = [LAContext new];
    
    //localizedReason: 指纹识别出现时的提示文字, 一般填写为什么使用指纹识别
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹识别, 开锁" reply:^(BOOL success, NSError * _Nullable error) {
        
        if (success)
        {
            //识别成功
            dispatch_async(dispatch_get_main_queue(), ^{
                self.PasscodeResult(@"fingerprint");
                self.infoView.infoCount = PasscodeCount;
            });
        }
        
        if (error)
        {
            if (error.code == -2)
            {
                NSLog(@"用户取消了操作");
            }
            else
            {
                NSLog(@"错误: %@",error);
            }
            
        }
        
    }];
}




@end
