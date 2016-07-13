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

@end

@implementation MYZHomeController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:alpha];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置当有导航栏自动添加64的高度的属性为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@" %ld -- %ld ", indexPath.section, indexPath.row];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"section-%ld", section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MYZNextViewController * vc = [[MYZNextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    alpha =  scrollView.contentOffset.y/64;
    
    alpha = (alpha <= 0)?0:alpha;
    alpha = (alpha >= 1)?1:alpha;
    
    //设置导航条上的标签是否跟着透明
    self.navigationItem.leftBarButtonItem.customView.alpha = alpha;
    self.navigationItem.titleView.alpha = alpha;
    self.navigationItem.rightBarButtonItem.customView.alpha = alpha;
    
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:alpha];
    
    
}


@end
