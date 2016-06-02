//
//  YKScrollPagingView.m
//  Login-Demo
//
//  Created by 张张张小烦 on 16/5/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKScrollPagingView.h"

#define IMAGE_TAG 100

@interface YKScrollPagingView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, assign) int imageCount;
@property (nonatomic, strong) NSArray *imageUrlArray;

@end

@implementation YKScrollPagingView

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}


- (void)setImageView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    CGFloat imageWidth = self.bounds.size.width;
    CGFloat imageHeight = self.bounds.size.height;
    
    //self.imageCount = 3;
    
    NSURL *urlOne = [NSURL URLWithString:@"http://bcs.91.com/rbpiczy/tagpic/2016/3/94e20eaafb904226a6d2574a64f5a2e2_294_640x256.jpg"];
    NSURL *urlTwo = [NSURL URLWithString:@"http://bcs.91.com/rbpiczy/tagpic/2015/10/42b773e2c87b485b9a4c7e2669935b73_294_640x256.jpg"];
    NSURL *urlThree = [NSURL URLWithString:@"http://bcs.91.com/rbpiczy/commonpics/2016/3/17/fc9b106c038a434fa6709a0843d7881d.jpg"];
    
    //NSArray *imgUrlArray = @[urlOne, urlTwo, urlThree];
    self.imageUrlArray = @[urlOne, urlTwo, urlThree];
    
    for (NSInteger i = 0; i < self.imageUrlArray.count; i++)
    {
        CGFloat imageX = i * imageWidth;
        CGFloat imageY = 0;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageWidth, imageHeight)];
        [imageView sd_setImageWithURL:self.imageUrlArray[i]];
        
        
        imageView.tag = IMAGE_TAG + i;
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        
        // 添加点击手势识别
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;       // 点击次数
        tap.numberOfTouchesRequired = 1;    // 点击手指数
        [imageView addGestureRecognizer:tap];
        
        
    }
    scrollView.contentSize = CGSizeMake(self.imageUrlArray.count * imageWidth, imageHeight);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    // 首页增加UIPageControl
    CGFloat pageControlW = 60;
    CGFloat pageControlH = 30;
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake((self.bounds.size.width - pageControlW) / 2, self.bounds.size.height - pageControlH, pageControlW, pageControlH);
    pageControl.numberOfPages = self.imageUrlArray.count;
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
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = timer;
}

- (void)nextPage {
    NSInteger index = self.scrollView.contentOffset.x / self.bounds.size.width;
    index ++;
    if (index == self.imageUrlArray.count) {
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











