//
//  YKClassifyWebViewController.m
//  91助手
//
//  Created by xiaofans on 16/7/15.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKClassifyWebViewController.h"

@interface YKClassifyWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *classifyWebVC;


@end

@implementation YKClassifyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.classifyWebVC.backgroundColor = YKBaseBgColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.classifyWebVC loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
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
