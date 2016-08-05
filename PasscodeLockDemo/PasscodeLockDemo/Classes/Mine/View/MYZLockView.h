//
//  MYZLockView.h
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/25.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const GestureCodeKey;

@interface MYZLockView : UIScrollView

@property (nonatomic, assign) BOOL showPasscodeViewBool;

@property (nonatomic, assign) BOOL showGestureViewBool;

@end
