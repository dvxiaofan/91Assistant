//
//  YKClassifyViewController.m
//  91助手
//
//  Created by xiaofan on 16/5/30.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKClassifyViewController.h"
#import "YKAppViewController.h"
#import "YKGameViewController.h"

@interface YKClassifyViewController ()<UIScrollViewDelegate>

/** segmentControll */
@property (nonatomic, strong) UISegmentedControl *segment;

/** scroll */
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YKClassifyViewController

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    
    [self setupSegment];
}

/**
 *  创建 滚动视图
 */
- (void)setupScrollView {
    // 不允许自动调整 view 的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.scrollEnabled = NO;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * SCREEN.width, SCREEN.height);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    /** 增加两个视图控制器 */
    YKAppViewController  *appVC  = [[YKAppViewController alloc] init];
    appVC.view.frame = CGRectMake(0, 0, SCREEN.width, SCREEN.height);
    [self addChildViewController:appVC];
    [scrollView addSubview:appVC.view];
    
    YKGameViewController *gameVC = [[YKGameViewController alloc] init];
    gameVC.view.frame = CGRectMake(SCREEN.width, 0, SCREEN.width, SCREEN.height);
    [self addChildViewController:gameVC];
    [scrollView addSubview:gameVC.view];
}

- (void)setupSegment {
    NSArray *itemArray = @[@"应用", @"游戏"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems: itemArray];
    segment.frame = CGRectMake(0, 0, 200, 30);
    segment.backgroundColor = [UIColor clearColor];
    [segment setTintColor:[UIColor whiteColor]];
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:YKTextBlackColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    self.segment = segment;
}

#pragma mark - 事件监听

- (void)segmentClick:(UISegmentedControl *)sender {
    // 滚动视图滚动到指定位置
    [self.scrollView setContentOffset:CGPointMake(self.segment.selectedSegmentIndex * self.scrollView.xf_width, 0) animated:NO];
}



@end



















