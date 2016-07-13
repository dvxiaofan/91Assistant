//
//  YKNavgationController.m
//  91助手
//
//  Created by xiaofans on 16/7/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKNavgationController.h"



@interface YKNavgationController ()<UIGestureRecognizerDelegate>

@end

@implementation YKNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_background_2"] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationBar setBackgroundColor:[UIColor blackColor]];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:19.0], NSFontAttributeName,nil]];
    [self.navigationBar setBarTintColor:[UIColor blackColor]];
}

/**
 *  重写 push 方法
 *
 *  @param viewController  push 进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 如果viewController不是最早push进来的子控制器才设置返回按钮
    if (self.childViewControllers.count > 0) {
        // 左上角按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"bar_back_normal"] forState:UIControlStateNormal];
        [backButton sizeToFit];
        backButton.frame = CGRectMake(0, 0, 50, 30);
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
        [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    // 完成所有设置后才 push控制器
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 监听返回按钮
- (void)backClick {
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}


@end
