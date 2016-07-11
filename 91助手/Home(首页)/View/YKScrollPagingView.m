//
//  YKScrollPagingView.m
//  Login-Demo
//
//  Created by 张张张小烦 on 16/5/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKScrollPagingView.h"
#import "YKApp.h"
#import "YKScrollModel.h"

#define IMAGE_TAG 100

@interface YKScrollPagingView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

@end

@implementation YKScrollPagingView

#pragma mark - 懒加载

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化

- (instancetype)init {
    if (self = [super init]) {
        [self loadNewData];
    }
    return self;
}

- (void)loadNewData {
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:HOME_SCROLL_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.sModel = [YKScrollModel mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][0][@"Value"]];
        
        [weakSelf setImageView:weakSelf.sModel];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error:%@", error);
        
    }];
}


- (void)setImageView:(NSArray *)ScrollImgArray {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat imageWidth = self.bounds.size.width;
    CGFloat imageHeight = self.bounds.size.height;
    
    for (NSInteger i = 0; i < ScrollImgArray.count; i++) {
        
        _scrollModel = ScrollImgArray[i];
        
        CGFloat imageX = i * imageWidth;
        CGFloat imageY = 0;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageWidth, imageHeight)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.scrollModel.LogoUrl]];
        
        imageView.tag = IMAGE_TAG + i;
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        
        // 添加点击手势识别
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;       // 点击次数
        tap.numberOfTouchesRequired = 1;    // 点击手指数
        [imageView addGestureRecognizer:tap];
        
    }
    scrollView.contentSize = CGSizeMake(self.sModel.count * imageWidth, imageHeight);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    // 首页增加UIPageControl
    CGFloat pageControlW = 60;
    CGFloat pageControlH = 30;
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake((self.bounds.size.width - pageControlW) / 2, self.bounds.size.height - pageControlH, pageControlW, pageControlH);
    pageControl.numberOfPages = self.sModel.count;
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    [self createTimer];
}

#pragma mark - tap点击事件
- (void)tap:(UITapGestureRecognizer *)sender {
    
    UIImageView *imageView = (UIImageView *)sender.view;
    // 判断代理方法是否被实现
    if ([self.delegate respondsToSelector:@selector(scrollPagingViewImageTapIndex:)]) {
        [self.delegate scrollPagingViewImageTapIndex:imageView.tag - IMAGE_TAG];
    }
}

#pragma mark - 设置定时自动轮播
- (void)createTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = timer;
}

- (void)nextPage {
    NSInteger index = self.scrollView.contentOffset.x / self.bounds.size.width;
    index ++;
    if (index == self.sModel.count) {
        index = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(index * self.bounds.size.width, 0) animated:YES];
}

#pragma mark - UIScrollView 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger currentPage = (scrollView.contentOffset.x + SCREEN.width * 0.5) / SCREEN.width;
    self.pageControl.currentPage = currentPage;
    
}

@end











