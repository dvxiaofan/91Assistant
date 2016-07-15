//
//  YKHomeViewController.m
//  91助手
//
//  Created by xiaofan on 16/5/30.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKHomeViewController.h"
#import "YKScrollPagingView.h"
#import "YKSingleRowTableViewCell.h"
#import "YKRowsTableViewCell.h"
#import "YKOtherTableViewCell.h"
#import "YKMoreViewController.h"
#import "YKDetailViewController.h"
#import "YKApp.h"
#import "YKSectionHeaderView.h"
#import "YKHomeModel.h"
#import "YKScrollModel.h"
#import "YKAppsViewController.h"



#define BTNBASETAG 100

@interface YKHomeViewController ()<YKScrollPagingViewDelegate,UITableViewDelegate,UITableViewDataSource,YKOtherTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** scroll */
@property (nonatomic, strong) YKScrollPagingView *scrollPV;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray <YKApp *>*oneSectionApps;

@property (nonatomic, strong) NSMutableArray <YKApp *>*fourSectionApps;

@property (nonatomic, strong) NSMutableArray <YKApp *>*fiveSectionApps;

@property (nonatomic, strong) NSMutableArray <YKApp *>*sixSectionApps;

/** homeData */
@property (nonatomic, strong) NSArray <YKHomeModel *>*homeData;

/** moreUrl */
@property (nonatomic, strong) NSArray *moreUrlArray;

/** namearray */
@property (nonatomic, strong) NSMutableArray *nameArray;
/** icon */
@property (nonatomic, strong) NSMutableArray *iconArray;

@end

static NSString *const YKSingleCellID        = @"YKSingleRowTableViewCell";
static NSString *const YKRowsCellID          = @"YKRowsTableViewCell";
static NSString *const YKOtherCellID         = @"YKOtherTableViewCell";
static NSString *const YKSectionHeaderViewID = @"YKSectionHeaderView";

@implementation YKHomeViewController

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
    
    self.navigationItem.title = @"9 1助手";
    
    // 创建TableView
    [self setupTableView];
    
    // 创建头部滚动视图
    [self setupScrollView];
    
    [self loadHomeData];
    
    [self setupRefresh];
    
    [self loadOneSectionData];
    
    [self loadFourSectionData];
    
    [self loadFiveSectionData];
    
    [self loadSixSectionData];
    
    [self setupMoreUrl];
    
}

- (void)setupScrollView {
    
    YKScrollPagingView *scrollPV = [[YKScrollPagingView alloc] init];
    scrollPV.frame = CGRectMake(0, 0, SCREEN.width, SCREEN.width * 7 / 16);
    scrollPV.delegate = self;
    self.scrollPV = scrollPV;
    
    self.tableView.tableHeaderView = scrollPV;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStyleGrouped];
    // 去掉系统分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[YKSingleRowTableViewCell class] forCellReuseIdentifier:YKSingleCellID];
    [tableView registerClass:[YKRowsTableViewCell class] forCellReuseIdentifier:YKRowsCellID];
    [tableView registerClass:[YKOtherTableViewCell class] forCellReuseIdentifier:YKOtherCellID];
    [tableView registerClass:[YKSectionHeaderView class] forHeaderFooterViewReuseIdentifier:YKSectionHeaderViewID];
}

- (void)setupRefresh {
    self.tableView.mj_header = [XFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeData)];
}

- (void)setupMoreUrl {
    self.moreUrlArray = @[HOME_HOT_URL, HOME_JINGPIN_URL, HOME_LIMIT_URL, HOME_BIBEI_URL, HOME_APP_URL, HOME_DARKHORSE_URL, HOME_EDITOR_URL];
}

#pragma mark - 加载数据

- (void)loadHomeData {
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:HOME_ZONG_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.homeData = [YKHomeModel mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][0][@"parts"]];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error:%@", error);
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

- (void)loadOneSectionData {
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:HOME_JINGPIN_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.oneSectionApps = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"items"]];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"rows error:%@", error);
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

- (void)loadFourSectionData {
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:HOME_APP_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.fourSectionApps = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"rows error:%@", error);
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

- (void)loadFiveSectionData {
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:HOME_DARKHORSE_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.fiveSectionApps = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"items"]];
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"rows error:%@", error);
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

- (void)loadSixSectionData {
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:HOME_EDITOR_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.sixSectionApps = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"items"]];
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"rows error:%@", error);
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

#pragma mark - <UITableViewDataSource>

// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.homeData.count;
}

// 每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.homeData[section].uiType == 4 ) {
        if (section == 6) {
            return self.sixSectionApps.count;
        } else {
            return 10;
        }
    } else {
        return 1;
    }
}

// 每行的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.homeData[indexPath.section].uiType == 1) {
        
        YKSingleRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YKSingleCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (self.homeData[indexPath.section].uiType == 4) {
        YKRowsTableViewCell *cellRows = [tableView dequeueReusableCellWithIdentifier:YKRowsCellID];
        
        if (indexPath.section == 1) {
            cellRows.app = self.oneSectionApps[indexPath.row];
        } else if (indexPath.section == 5) {
            cellRows.app = self.fiveSectionApps[indexPath.row];
        } else if (indexPath.section == 6) {
            cellRows.app = self.sixSectionApps[indexPath.row];
        }
        
        cellRows.selectionStyle = UITableViewCellSelectionStyleNone;
        [cellRows.downBtn addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cellRows;
    }  else {
        YKOtherTableViewCell *cellOther = [tableView dequeueReusableCellWithIdentifier:YKOtherCellID];
        cellOther.selectionStyle = UITableViewCellSelectionStyleNone;
        cellOther.delegate = self;
        return cellOther;
    }
}

#pragma mark - <UITableViewDelegate>

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    YKSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:YKSectionHeaderViewID];
    headerView.homeData = self.homeData[section];
    headerView.moreBtn.tag = section;
    headerView.textLabel.text = self.homeData[section].name;
    [headerView.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return headerView;
    
}

// header 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}
// footer 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

// 每个 cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.homeData[indexPath.section].uiType == 1) {
        return self.oneSectionApps[indexPath.row].singleCellHeight;
        
    } else if (self.homeData[indexPath.section].uiType == 4) {
        return self.oneSectionApps[indexPath.row].rowsCellHeight;
    } else {
        return self.oneSectionApps[indexPath.row].appCellHeight;
    }
}
// 点击每一个 cell 的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.homeData[indexPath.section].uiType == 4) {
        YKDetailViewController *detailVC = [[YKDetailViewController alloc] init];
        if (indexPath.section == 1) {
            detailVC.url = self.oneSectionApps[indexPath.row].detailUrl;
        } else if (indexPath.section == 5) {
            detailVC.url = self.fiveSectionApps[indexPath.row].detailUrl;
        } else if (indexPath.section == 6) {
            detailVC.url = self.sixSectionApps[indexPath.row].detailUrl;
        }
        
        detailVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        return;
    }
}

#pragma mark - 监听

- (void)moreBtnClick:(UIButton *)button {
    
    NSInteger tag = button.tag;
    
    if (tag == 4) {
        YKAppsViewController *appsVC = [[YKAppsViewController alloc] init];
        appsVC.navTitle = self.homeData[tag].name;
        appsVC.url = self.moreUrlArray[tag];
        
        [self.navigationController pushViewController:appsVC animated:YES];
        
    } else {
        YKMoreViewController *moreVC = [[YKMoreViewController alloc] init];
        moreVC.navTitle = self.homeData[tag].name;
        moreVC.url = self.moreUrlArray[tag];
        
        [self.navigationController pushViewController:moreVC animated:YES];
    }
    
}

- (void)scrollPagingViewImageTapIndex:(NSInteger)index {
    
    YKMoreViewController *moreVC = [[YKMoreViewController alloc] init];
    moreVC.navTitle = self.scrollPV.sModel[index].Desc;
    moreVC.url = self.scrollPV.sModel[index].TargetUrl;
    [self.navigationController pushViewController:moreVC animated:YES];
    
}

- (void)downBtnClick:(UIButton *)button {
    YKWebViewController *webVC = [[YKWebViewController alloc] init];
    webVC.navTitle = @"App Store";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)imgViewTapIndex:(NSInteger)index {
    YKMoreViewController *moreVC = [[YKMoreViewController alloc] init];
    moreVC.navTitle = self.fourSectionApps[index].name;
    moreVC.url = self.fourSectionApps[index].url;
    [self.navigationController pushViewController:moreVC animated:YES];
}




@end








