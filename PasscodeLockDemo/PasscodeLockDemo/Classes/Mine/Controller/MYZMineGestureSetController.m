//
//  MYZMineGestureSetController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/8/4.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZMineGestureSetController.h"
#import "MYZGestureView.h"

@interface MYZMineGestureSetController ()

@property (nonatomic, weak) UIView * shapeView;

@property (nonatomic, weak) UILabel * infoLabel;

@property (nonatomic, weak) MYZGestureView * gestureView;

@end

@implementation MYZMineGestureSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.gestureSetType == GestureSetTypeInstall)
    {
        
    }
    
    UILabel * infoLabel = [[UILabel alloc] init];
    
}






@end
