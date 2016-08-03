//
//  MYZGestureView.h
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/28.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYZGestureView : UIView

@property (nonatomic, copy) void(^gestureResult)(NSString * gestureCode);


@end
