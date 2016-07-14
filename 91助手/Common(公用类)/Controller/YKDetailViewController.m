//
//  YKDetailViewController.m
//  91助手
//
//  Created by xiaofan on 16/6/7.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKDetailViewController.h"
#import "YKDetailHeaderView.h"
#import "YKDetailModel.h"

@interface YKDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView           *tableView;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

/** m */
@property (nonatomic, strong) YKDetailModel *detailModel;

@end

@implementation YKDetailViewController

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
    
    [self setupNav];
    
    [self loadDetailData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupTableView];
    });
}

- (void)setupNav {
    
    self.view.userInteractionEnabled = YES;
    
}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStylePlain];
    // 去掉系统分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    // header 视图
    YKDetailHeaderView *headerView = [[YKDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 320)];
    
    [headerView createViewWithModel:self.detailModel];
    
    
    
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:headerView.frame];
    [tableView.tableHeaderView addSubview:headerView];
}

#pragma mark - 加载数据

- (void)loadDetailData {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //YKLog(@"success");
        weakSelf.detailModel = [YKDetailModel mj_objectWithKeyValues:responseObject[@"Result"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败,请稍候再试"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", [self class], indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    YKLogFunc
}

@end



















