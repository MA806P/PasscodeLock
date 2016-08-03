//
//  MYZGestureView.h
//  PasscodeLockDemo
//
//  Created by MA806P on 16/7/28.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYZGestureView : UIView

//- (void)gestureOperatedSuccess:(void (^)(NSString * gestureCode))success failure:(void (^)(NSString * erroMessage))failure;

@property (nonatomic, copy) void(^gestureResult)(NSString * gestureCode);


@end
