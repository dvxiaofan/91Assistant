//
//  YKHomeViewController.m
//  91助手
//
//  Created by xiaofan on 16/5/30.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKHomeViewController.h"
#import "YKScrollPagingView.h"

@interface YKHomeViewController ()<YKScrollPagingViewDelegate>

@end

@implementation YKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"9 1助手";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupScrollView];
    
    
}

#pragma mark - 设置顶部滚动视图
- (void)setupScrollView {
    
    YKScrollPagingView *scrollPV = [[YKScrollPagingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height * 4.5 / 16)];
    scrollPV.backgroundColor = [UIColor yellowColor];
    [scrollPV setImageView];
    // 设置代理
    scrollPV.delegate = self;
    [self.view addSubview:scrollPV];
}

#pragma mark - YKScrollPagingView 代理方法

- (void)scrollPagingViewImageTapIndex:(NSInteger)index {
    YKLog(@"第%ld张图被点击",(long)index);
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
