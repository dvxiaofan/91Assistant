//
//  YKDownViewController.m
//  91助手
//
//  Created by xiaofans on 16/7/15.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKDownViewController.h"

@interface YKDownViewController ()

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager  *manager;

@end

@implementation YKDownViewController

#pragma mark - 懒加载

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(YKMargin, 0, 40, 25);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    nav.navigationItem.leftBarButtonItem = left;
    
    [self loadData];
}

- (void)loadData {
    
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSString *downUrl = responseObject[@"Result"][@"appleDetailUrl"];
        //YKLog(@"uuu = %@", downUrl);
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:downUrl]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error:%@", error);
    }];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
