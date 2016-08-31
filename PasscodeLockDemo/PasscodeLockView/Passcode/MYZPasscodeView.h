//
//  MYZPasscodeView.h
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/28.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYZPasscodeView : UIView

- (void)showFingerprintTouch;

@property (nonatomic, copy) BOOL(^PasscodeResult)(NSString * passcode);

@property (nonatomic, getter=isHideFingerprintBtn) BOOL hideFingerprintBtn;

@end
