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
#import "YKDetailSingelScrollCell.h"
#import "YKDetailFooterView.h"
#import "YKDetailSummaryCell.h"

@interface YKDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView           *tableView;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

/** m */
@property (nonatomic, strong) YKDetailModel *detailModel;

/** singleScrollCell */
@property (nonatomic, strong) YKDetailSingelScrollCell *scrollCell;
/** summaryCell */
@property (nonatomic, strong) YKDetailSummaryCell *summaryCell;

@end

static NSString *const YKSingleScrollCellID = @"YKDetailSingelScrollCell";
static NSString *const YKSummaryCellID = @"YKDetailSummaryCell";

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
    
    
    [self setupView];
    
    [self loadDetailData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupTableView];
    });
}

- (void)setupView {
    
    self.view.userInteractionEnabled = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // 去掉系统分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = YKGrayColor(226);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[YKDetailSingelScrollCell class] forCellReuseIdentifier:YKSingleScrollCellID];
    [tableView registerClass:[YKDetailSummaryCell class] forCellReuseIdentifier:YKSummaryCellID];
    
    // header 视图
    YKDetailHeaderView *headerView = [[YKDetailHeaderView alloc] init];
    [headerView createViewWithModel:self.detailModel];
    headerView.frame = CGRectMake(0, 0, SCREEN.width, headerView.headerViewHeight);
    
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:headerView.frame];
    [tableView.tableHeaderView addSubview:headerView];
    
    // footerView
    YKDetailFooterView *footerView = [[YKDetailFooterView alloc] init];
    [footerView createViewWithModel:self.detailModel];
    footerView.frame = CGRectMake(0, 0, SCREEN.width, footerView.footerViewHeight);
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:footerView.frame];
    [tableView.tableFooterView addSubview:footerView];
    
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
    
    if (indexPath.row == 0) {
        YKDetailSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:YKSummaryCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell createCellWithModel:self.detailModel];
        self.summaryCell = cell;
        
        return cell;
    } else {
        YKDetailSingelScrollCell * scrollCell = [tableView dequeueReusableCellWithIdentifier:YKSingleScrollCellID];
        
        scrollCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [scrollCell createCellWithModel:self.detailModel];
        self.scrollCell = scrollCell;
        return scrollCell;
    }
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return self.summaryCell.cellHeight;
    } else {
        return self.scrollCell.cellHeight;
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //YKLogFunc
//}

@end



















