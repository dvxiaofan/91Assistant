//
//  YKClassifyAppViewController.m
//  91助手
//
//  Created by xiaofans on 16/7/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKClassifyAppViewController.h"
#import "YKClassifyCell.h"
#import "YKClassify.h"
#import "YKListTags.h"
#import "YKClassifyBaseViewController.h"

@interface YKClassifyAppViewController ()

/** 数据 */
@property (nonatomic, strong) NSArray <YKClassify *>*appArray;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

@end

static NSString *const YKClassifyCellID = @"YKClassifyCell";

@implementation YKClassifyAppViewController

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
}

- (void)setupTableView {
    self.tableView.backgroundColor = YKBaseBgColor;
    
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerClass:[YKClassifyCell class] forCellReuseIdentifier:YKClassifyCellID];
}

- (void)setupRefresh {
    self.tableView.mj_header = [XFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 加载数据

- (void)loadData {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.appArray = [YKClassify mj_objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败，请稍候再试"];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:YKClassifyCellID];
    
    cell.app = self.appArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.appArray[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKClassifyBaseViewController *baseVC = [[YKClassifyBaseViewController alloc] init];
    baseVC.navTitle = self.appArray[indexPath.row].name;
    [self.navigationController pushViewController:baseVC animated:YES];
    
}


@end












