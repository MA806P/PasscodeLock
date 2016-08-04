//
//  MYZMineGestureSetController.h
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/8/4.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum: NSUInteger {
    GestureSetTypeInstall,
    GestureSetTypeVerify
    
}GestureSetType;

//typedef void(^GestureSetLock)(BOOL locked);

@interface MYZMineGestureSetController : UIViewController

@property (nonatomic, assign) GestureSetType gestureSetType;

//@property (nonatomic, copy)GestureSetLock lockBlock;

@end
