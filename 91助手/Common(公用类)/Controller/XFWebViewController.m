//
//  XFWebViewController.m
//  XFBaisi
//
//  Created by xiaofans on 16/6/27.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

#import "XFWebViewController.h"

@interface XFWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation XFWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = self.navTitle;
    self.webView.backgroundColor = YKBaseBgColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - 监听点击

- (IBAction)reload {    // 刷新
    [self.webView reload];
}






@end












