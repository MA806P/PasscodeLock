//
//  MYZCircleView.h
//  PasscodeLockDemo
//
//  Created by MA806P on 16/8/1.
//  Copyright © 2016年 myz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CircleViewStatusNormal,
    CircleViewStatusSelected,
    CircleViewStatusError,
} CircleViewStatus;

@interface MYZCircleView : UIView

@property (nonatomic, assign) CircleViewStatus circleStatus;


@end
