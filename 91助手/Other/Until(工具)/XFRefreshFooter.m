//
//  XFRefreshFooter.m
//  XFBaisi
//
//  Created by xiaofans on 16/6/29.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

#import "XFRefreshFooter.h"

@implementation XFRefreshFooter

- (void)prepare {
    [super prepare];
    
    [self setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
    
    // 自动隐藏刷新控件
    self.automaticallyHidden = YES;
    
    // 自动刷新
    //self.automaticallyRefresh = NO;
    
    // 自定义字体颜色
    //self.stateLabel.textColor = [UIColor redColor];
}

@end
