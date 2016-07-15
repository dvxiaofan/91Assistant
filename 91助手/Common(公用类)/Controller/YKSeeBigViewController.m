//
//  YKSeeBigViewController.m
//  91助手
//
//  Created by xiaofans on 16/7/15.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSeeBigViewController.h"
#import "YKDetailModel.h"

@interface YKSeeBigViewController ()<UIScrollViewDelegate>

/** imageView */
@property (nonatomic, strong) UIImageView     *imageView;

/** pageContrl */
@property (nonatomic, strong) UIPageControl *pageControl;



@end

@implementation YKSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    scrollView.delegate = self;
    
    NSArray *imageArray = self.model.snapshots;
    
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageMargin = YKMargin * 2;
        imageView.xf_width = SCREEN.width - imageMargin * 2;
        imageView.xf_x = imageMargin + SCREEN.width * i ;
        imageView.xf_y = 0;
        imageView.xf_height = SCREEN.height;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:[UIImage imageNamed:@"avatar_poto_defaul140"]];
        
        [scrollView addSubview:imageView];
        self.imageView = imageView;
        imageView.userInteractionEnabled = YES;
        
        // 增加点击手势
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [imageView addGestureRecognizer:tapGR];
        
    }
    scrollView.contentSize = CGSizeMake(SCREEN.width * imageArray.count, SCREEN.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    // 增加PageControl
    CGFloat pageControlW = 60;
    CGFloat pageControlH = 30;
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake((SCREEN.width - pageControlW) / 2, SCREEN.height - pageControlH, pageControlW, pageControlH);
    pageControl.numberOfPages = imageArray.count;
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
}

//-(BOOL)prefersStatusBarHidden {
    //return YES;
//}

#pragma mark - UIScrollView 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger currentPage = (scrollView.contentOffset.x + SCREEN.width * 0.5) / SCREEN.width;
    self.pageControl.currentPage = currentPage;
    
}


#pragma mark - 事件监听

- (void)tapClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end










