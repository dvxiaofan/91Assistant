//
//  YKClassifyDataViewController.m
//  91助手
//
//  Created by xiaofans on 16/7/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKClassifyDataViewController.h"
#import "YKRowsTableViewCell.h"
#import "YKDetailViewController.h"
#import "YKApp.h"
#import "YKClassifyWebViewController.h"


@interface YKClassifyDataViewController ()
/** 任务管理者 */
@property (nonatomic, strong) XFHTTPSessionManager      *manager;

@property (nonatomic, strong) NSMutableArray <YKApp *>*apps;

/** lll */
@property (nonatomic, strong) UILabel *alertLabel;

@end

static NSString *const YKRowsCellID = @"YKRowsTableViewCell";

@implementation YKClassifyDataViewController

#pragma mark - 懒加载
- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabelView];
    
    [self firstLoadData];
    
    [self setupRefresh];
}

- (void)setupTabelView {
    self.tableView.backgroundColor = YKBaseBgColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone; // 取消底部分割线
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 30, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerClass:[YKRowsTableViewCell class] forCellReuseIdentifier:YKRowsCellID];
    
}

- (void)setupRefresh {
    self.tableView.mj_header = [XFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [XFRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - 加载数据

// 第一次加载数据
- (void)firstLoadData {
    
    [SVProgressHUD showWithStatus:@"加载中,请稍候..."];
    
    // 经测试,需要延迟一点加载,否则 URL 可能为空
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadNewData];
    });
}


/**
 *  刷新数据
 */
- (void)loadNewData {
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
    // 请求
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        weakSelf.apps = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"items"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
        
        if (weakSelf.apps.count == 0) {
            [YKTools showAlertView:self title:@"友情提示:" message:@"暂时没有数据" cancelButtonTitle:@"确定" otherButtonTitle:@"取消"];
        }
        
        
        // 控件结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"请求失败 - %@", error);
        
        [SVProgressHUD showErrorWithStatus:@"加载失败,请稍候再试!"];
        // 控件结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

/**
 *  加载更多数据
 */
-(void)loadMoreData {
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        YKLog(@"more success");
        
        
        // 刷新表格
        [self.tableView reloadData];
        
        //控件结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"请求失败 - %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败,请稍候再试!"];
        // 控件结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKRowsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YKRowsCellID];
    cell.app = self.apps[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.downBtn addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.apps[indexPath.row].rowsCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //YKDetailViewController *detailView = [[YKDetailViewController alloc] init];
    //detailView.url = self.apps[indexPath.row].detailUrl;
    //detailView.hidesBottomBarWhenPushed = YES;
    
    //[self.navigationController pushViewController:detailView animated:YES];
    
    YKClassifyWebViewController *detailVC = [[YKClassifyWebViewController alloc] init];
    detailVC.url = self.apps[indexPath.row].detailUrl;
    detailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController: detailVC animated:YES];
    
    
}

#pragma mark  - 事件监听

- (void)downBtnClick:(UIButton *)button {
    YKLogFunc
}

@end















