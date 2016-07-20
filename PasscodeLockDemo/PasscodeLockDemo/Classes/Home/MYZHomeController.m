//
//  MYZHomeController.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/13.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "MYZHomeController.h"
#import "MYZNextViewController.h"

static NSString * const CellId = @"CellId";
static CGFloat alpha = 0;

@interface MYZHomeController ()

@property (nonatomic, assign) BOOL isChangeStatusBar;

@end

@implementation MYZHomeController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self scrollViewDidScroll:self.tableView];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置当有导航栏自动添加64的高度的属性为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 46, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellId];
    
    
    //设置tableView的头部视图
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 250)];
    imageView.image = [UIImage imageNamed:@"11"];
    self.tableView.tableHeaderView = imageView;
    
    
    /*
    //设置导航条上的标签是否跟着透明
    self.navigationItem.leftBarButtonItem.customView.alpha = self.isLeftAlpha?alpha:1;
    self.navigationItem.titleView.alpha = self.isTitleAlpha?alpha:1;
    self.navigationItem.rightBarButtonItem.customView.alpha = self.isRightAlpha?alpha:1;
    */
    
    
//    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0];
//    //设置背景图片
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    //清除边框，设置一张空的图片
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@" %d -- %d ", (int)indexPath.section, (int)indexPath.row];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"section-%d", (int)section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MYZNextViewController * vc = [[MYZNextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    alpha =  scrollView.contentOffset.y/200.0;
    
    alpha = (alpha <= 0)?0:alpha;
    alpha = (alpha >= 1)?1:alpha;
    
    
    //NSLog(@" --- %.2f", alpha);
    
    UIColor * titleColor;
    
    if (alpha > 0.6)
    {
        self.isChangeStatusBar = YES;
        titleColor = [UIColor blackColor];
    }
    else
    {
        self.isChangeStatusBar = NO;
        titleColor = [UIColor whiteColor];
    }
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }

    
    //设置导航条上的标签是否跟着透明
    //self.navigationItem.leftBarButtonItem.customView.alpha = alpha;
    //self.navigationItem.rightBarButtonItem.customView.alpha = alpha;
    //self.navigationItem.titleView.alpha = alpha;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[titleColor colorWithAlphaComponent:alpha]};
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.isChangeStatusBar)
    {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}


@end
