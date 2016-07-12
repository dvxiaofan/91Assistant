//
//  YKClassifyBaseViewController.m
//  91助手
//
//  Created by xiaofans on 16/7/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKClassifyBaseViewController.h"
#import "YKFreeAppsViewController.h"
#import "YKLimitViewController.h"
#import "YKFallViewController.h"
#import "YKMoneyAppsViewController.h"
#import "YKTitleButton.h"
#import "YKListTags.h"

@interface YKClassifyBaseViewController ()<UIScrollViewDelegate>

/** 当前选中的标题按钮 */
@property (nonatomic, weak) YKTitleButton *selectedTitleBtn;
/** 标题按钮底部指示器 */
@property (nonatomic, weak) UIView        *indicatorView;
/** 滚动视图 */
@property (nonatomic, weak) UIScrollView  *scrollView;

/** 滚动titleSView */
@property (nonatomic, weak) UIScrollView  *titleSView;

/** n */
@property (nonatomic, strong) NSArray <YKListTags *>*list;

/** tageName */
@property (nonatomic, strong) NSMutableArray *tagNameArray;

/** url */
@property (nonatomic, strong) NSMutableArray *urlArray;

@end

@implementation YKClassifyBaseViewController

#pragma mark - 懒加载

- (NSMutableArray *)tagNameArray {
    if (!_tagNameArray) {
        _tagNameArray = [NSMutableArray array];
    }
    return _tagNameArray;
}

- (NSMutableArray *)urlArray {
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainData];
    
    [self setupChildViewControllers];
    
    [self setupScrollView];
    
    [self setupTitleView];
    
    [self addChildVcView];
}

- (void)setupMainData {
    self.navigationItem.title = self.navTitle;
    
    // 标题栏数据
    for (NSDictionary *dic in self.listTags) {
        
        NSString *name = dic[@"tagName"];
        NSString *url = dic[@"url"];
        
        [self.tagNameArray addObject:name];
        [self.urlArray addObject:url];
    }
}

- (void)setupChildViewControllers {
    YKFreeAppsViewController   *freeView        = [[YKFreeAppsViewController alloc] init];
    freeView.urlArray = self.urlArray;
    [self addChildViewController:freeView];
    
    YKLimitViewController      *limitView       = [[YKLimitViewController alloc] init];
    limitView.urlArray = self.urlArray;
    [self addChildViewController:limitView];
    
    YKFallViewController       *fallView        = [[YKFallViewController alloc] init];
    fallView.urlArray = self.urlArray;
    [self addChildViewController:fallView];
    
    YKMoneyAppsViewController  *moneyView       = [[YKMoneyAppsViewController alloc] init];
    moneyView.urlArray = self.urlArray;
    [self addChildViewController:moneyView];
}


/**
 *  创建 滚动视图
 */
- (void)setupScrollView {
    // 不允许自动调整 view 的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = YKBaseBgColor;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollEnabled = NO;
    scrollView.frame = CGRectMake(0, 0, SCREEN.width, SCREEN.height);
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.xf_width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

/**
 *  创建 顶部标题栏
 */
- (void)setupTitleView {
    
    UIScrollView *titleSView = [[UIScrollView alloc] init];
    titleSView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_background"]];
    titleSView.frame = CGRectMake(0, 64, self.view.xf_width, 30);
    [self.view addSubview:titleSView];
    self.titleSView = titleSView;
    
    // 添加按钮
    NSInteger count = self.tagNameArray.count;
    CGFloat titleBtnW = SCREEN.width / 4;
    CGFloat titleBtnH = titleSView.xf_height;
    
    for (NSUInteger i = 0; i < count; i++) {
        YKTitleButton *titleBtn = [YKTitleButton buttonWithType:UIButtonTypeCustom];
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleSView addSubview:titleBtn];
        titleBtn.tag = i;
        
        // 设置数据
        [titleBtn setTitle:self.tagNameArray[i] forState:UIControlStateNormal];
        
        // 设置 frame
        titleBtn.frame = CGRectMake(i * titleBtnW, 0, titleBtnW, titleBtnH);
    }
    
    YKTitleButton *firstTitleButton = titleSView.subviews.firstObject;
    
    // 底部选中指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.xf_height = 3;
    indicatorView.xf_y = titleSView.xf_height - indicatorView.xf_height;
    [titleSView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 立即根据文字内容计算 label 的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.xf_width = firstTitleButton.titleLabel.xf_width;
    indicatorView.xf_centerX = firstTitleButton.xf_centerX;
    
    // 默认选中最前面的按钮
    firstTitleButton.selected = YES;
    self.selectedTitleBtn = firstTitleButton;
    
    titleSView.contentSize = CGSizeMake(count * titleBtnW, titleSView.xf_height);
    titleSView.showsHorizontalScrollIndicator = NO;
    titleSView.showsVerticalScrollIndicator = NO;
}

#pragma mark - 监听按钮点击

/**
 *  顶部标题按钮点击事件
 */
- (void)titleClick:(YKTitleButton *)titleButton {
    // 控制按钮状态
    self.selectedTitleBtn.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleBtn = titleButton;
    
    // 指示器
    self.indicatorView.xf_width = titleButton.titleLabel.xf_width;
    self.indicatorView.xf_centerX = titleButton.xf_centerX;
    
    // 滚动视图滚动到指定位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.xf_width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - 添加子控制器的view
- (void)addChildVcView {
    
    // 添加子控制器的 view 到 scrollview 中
    NSUInteger index = self.scrollView.contentOffset.x / SCREEN.width;
    
    // 取出子控制器
    UIViewController *childVC = self.childViewControllers[index];
    
    if (childVC.view.window) return; // 如果窗口已经创建，就不需要再设置 frame
    
    childVC.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVC.view];
}

#pragma mark - <UIScrollViewDelegate>

/**
 *  使用有动画的方法结束时才调用这个方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
   
    [self addChildVcView];
}




@end






