//
//  YKAppsViewController.m
//  91助手
//
//  Created by xiaofans on 16/7/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKAppsViewController.h"
#import "YKAppsViewCell.h"
#import "YKApp.h"
#import "YKMoreViewController.h"

@interface YKAppsViewController ()

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;
/** apps */
@property (nonatomic, strong) NSArray <YKApp *>*appsArray;

@end

static NSString *const YKAppsViewCellID = @"YKAppsViewCell";

@implementation YKAppsViewController

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
}

- (void)setupTableView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.navTitle;
    
    [self.tableView registerClass:[YKAppsViewCell class] forCellReuseIdentifier:YKAppsViewCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [XFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadData {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
   
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.appsArray = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error = %@", error);
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.appsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKAppsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YKAppsViewCellID];
    cell.app = self.appsArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.appsArray[indexPath.row].appCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YKMoreViewController *moreVC = [[YKMoreViewController alloc] init];
    moreVC.navTitle = self.appsArray[indexPath.row].name;
    moreVC.url = self.appsArray[indexPath.row].url;
    [self.navigationController pushViewController:moreVC animated:YES];
}




@end
