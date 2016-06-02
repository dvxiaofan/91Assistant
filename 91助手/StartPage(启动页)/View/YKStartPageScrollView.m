//
//  YKStartPageScrollView.m
//  91助手
//
//  Created by xiaofan on 16/5/30.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKStartPageScrollView.h"
#import "UIView+YKExtension.h"


@interface YKStartPageScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation YKStartPageScrollView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)setView {
    // 创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, SCREEN.width, SCREEN.height);
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    
    // 创建滚动显示图片
    NSArray *imageArray = @[[UIImage imageNamed:@"start_page_1"], [UIImage imageNamed:@"start_page_2"], [UIImage imageNamed:@"start_page_3"]];
    
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImage *image = imageArray[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.x = i * SCREEN.width;
        imageView.y = 0;
        imageView.width = SCREEN.width;
        imageView.height = SCREEN.height;
        self.imageView = imageView;
        [scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES; // 允许交互
        
        // 最后一个页面添加进入按钮
        if (i == (imageArray.count - 1)) {
            // 增加按钮
            [self addStartButton];
        }
        // 设置滚动范围等属性
        scrollView.contentSize = CGSizeMake(SCREEN.width * imageArray.count, 0);
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        // 创建pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.width = 60;
        pageControl.height = 30;
        pageControl.centerX = SCREEN.width * 0.5;
        pageControl.centerY = SCREEN.height - 55;
        pageControl.numberOfPages = imageArray.count;
        pageControl.userInteractionEnabled = NO;
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger currentPage = (scrollView.contentOffset.x + SCREEN.width * 0.5) / SCREEN.width;   // 页面显示过半就切换
    self.pageControl.currentPage = currentPage;
}

#pragma mark - 创建进入按钮
- (void)addStartButton {
    UIButton *button = [[UIButton alloc] init];
    button.width = 130;
    button.height = 36;
    button.centerX = SCREEN.width * 0.5;
    button.centerY = SCREEN.height - 120;
    
    [button setTitle:@"立即进入" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button.layer setCornerRadius:18.0];
    [button.layer setBorderColor:[UIColor whiteColor].CGColor];
    [button.layer setBorderWidth:1.0];
    [button.layer setMasksToBounds:YES];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.imageView addSubview:button];
}

#pragma mark - 按钮点击事件
-(void)btnClick:(UIButton *)button {
    //YKLog(@"点击进入");
    if ([self.delegate respondsToSelector:@selector(startBtnClick)]) {
        [self.delegate startBtnClick];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
