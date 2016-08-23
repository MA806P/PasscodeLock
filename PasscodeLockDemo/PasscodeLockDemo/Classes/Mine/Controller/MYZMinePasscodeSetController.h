//
//  MYZMinePasscodeSetController.h
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/8/23.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const PasscodeKey;

typedef enum : NSUInteger {
    PasscodeSetTypeInstal = 1,
    PasscodeSetTypeDelete,
    PasscodeSetTypeChange,
} PasscodeSetType;

typedef void(^PasscodeSetLock)(BOOL locked);

@interface MYZMinePasscodeSetController : UIViewController

@property (nonatomic, assign) PasscodeSetType passcodeType;

@property (nonatomic, copy) PasscodeSetLock lockBlock;

@end
