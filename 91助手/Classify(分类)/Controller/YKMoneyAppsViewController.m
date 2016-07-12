//
//  YKMoneyAppsViewController.m
//  91助手
//
//  Created by xiaofans on 16/7/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKMoneyAppsViewController.h"

@interface YKMoneyAppsViewController ()

@end

@implementation YKMoneyAppsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YKLogFunc
    self.url = @"http://applebbx.sj.91.com/soft/phone/list.aspx?act=214&cid=6023&title=%e7%be%8e%e9%a3%9f%e4%bd%b3%e9%a5%ae&mt=1&sv=1.0.0&pid=2&osv=&spid=2&pt=5";
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
