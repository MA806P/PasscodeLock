//
//  MYZNextViewController.h
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/13.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureSetLock)(BOOL locked);

@interface MYZNextViewController : UIViewController


@property (nonatomic, assign)BOOL locked;

@property (nonatomic, copy)GestureSetLock lockBlock;

@end
