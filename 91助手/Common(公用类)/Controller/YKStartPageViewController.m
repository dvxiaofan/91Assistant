//
//  YKStartPageViewController.m
//  91助手
//
//  Created by xiaofan on 16/5/30.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKStartPageViewController.h"
#import "YKStartPageScrollView.h"
#import "YKRootViewController.h"



@interface YKStartPageViewController ()<UIScrollViewDelegate,YKStartPageScrollViewDelegate>

@property (nonatomic, strong) YKStartPageScrollView *startView;

@end

@implementation YKStartPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self setupStartView];
    // Do any additional setup after loading the view.
}

#pragma mark - 设置滚动视图

- (void)setupStartView {
    YKStartPageScrollView *startView = [[YKStartPageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height)];
    [startView setView];
    [self.view addSubview:startView];
    startView.delegate = self;
    self.startView = startView;
}

#pragma mark - YKStartPageScrollViewDelegate

- (void)startBtnClick {
    //YKLog(@"点击进入按钮");
    
    YKRootViewController *rootVC = [[YKRootViewController alloc] init];
    [self presentViewController:rootVC animated:YES completion:nil];
    
    //UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //keyWindow.rootViewController = rootVC;
    
    // 动画
    //[UIView animateWithDuration:2 animations:^{
        //self.startView.alpha = 0;
    //} completion:nil];
    
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
