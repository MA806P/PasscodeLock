//
//  MYZLockView.h
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/25.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const GestureCodeKey;
FOUNDATION_EXPORT NSString * const GesturePathText; //显示手势轨迹

FOUNDATION_EXPORT NSString * const PasscodeKey;
FOUNDATION_EXPORT NSString * const TouchIDText;
FOUNDATION_EXPORT NSString * const RemindTouchID;

@interface MYZLockView : UIView

- (void)showRemindFingerprint;

@property (nonatomic, assign) BOOL showPasscodeViewBool;

@property (nonatomic, assign) BOOL showGestureViewBool;

@end
