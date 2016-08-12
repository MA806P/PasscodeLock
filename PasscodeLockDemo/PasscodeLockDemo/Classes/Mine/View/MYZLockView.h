//
//  MYZLockView.h
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/25.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const GestureCodeKey;
//显示手势轨迹
FOUNDATION_EXPORT NSString * const GesturePathText;

@interface MYZLockView : UIView

@property (nonatomic, assign) BOOL showPasscodeViewBool;

@property (nonatomic, assign) BOOL showGestureViewBool;

@end
