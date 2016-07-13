//
//  YKDetailViewController.m
//  91助手
//
//  Created by xiaofan on 16/6/7.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKDetailViewController.h"

@interface YKDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView           *tableView;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

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
    self.navigationItem.title = @"详情页";
    
    
    [self setupTableView];
    
    [self loadDetailData];
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
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREEN.width, 300);
    headerView.backgroundColor = [UIColor orangeColor];
    tableView.tableHeaderView = headerView;
    
    
    // footer 视图
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(0, 0, SCREEN.width, 200);
    textView.backgroundColor = YKBaseBgColor;
    //textView.
    textView.text = @"信息/n,下载:667万次/n 分类拉进来快接啊;附近啊;卡减肥; 安家费;按键;附近啊;打飞机; 啊交电费;啊缴费单;按键;林凤娇啊; 大姐夫;啊解放军啊";
    
    tableView.tableFooterView = textView;
    
    //[self.tableView registerClass:[YKRowsTableViewCell class] forCellReuseIdentifier:YKRowsCellID];
}

#pragma mark - 加载数据

- (void)loadDetailData {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YKLog(@"success");
        
        
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


@end



















