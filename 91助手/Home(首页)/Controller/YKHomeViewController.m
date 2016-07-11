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



#define BTNBASETAG 100

@interface YKHomeViewController ()<YKScrollPagingViewDelegate,UITableViewDelegate,UITableViewDataSource,YKSingleRowTableViewCellDelegate,YKOtherTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YKSingleRowTableViewCell *cell;

@property (nonatomic, strong) YKRowsTableViewCell *cellRows;

@property (nonatomic, strong) YKOtherTableViewCell *cellOther;

/** scroll */
@property (nonatomic, strong) YKScrollPagingView *scrollPV;

//@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) NSMutableArray *sectionNameArray;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray <YKApp *>*apps;

/** homeData */
@property (nonatomic, strong) NSArray <YKHomeModel *>*homeData;



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
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"9 1助手";
    
    // 创建TableView
    [self setupTableView];
    
    // 创建头部滚动视图
    [self setupScrollView];
    
    [self setupRefresh];
    
    [self loadRowsCellData];
}

- (void)setupScrollView {
    
    YKScrollPagingView *scrollPV = [[YKScrollPagingView alloc] init];//WithFrame:
    scrollPV.frame = CGRectMake(0, 0, SCREEN.width, SCREEN.width * 7 / 16);
    //[scrollPV setImageView];
    // 设置代理
    scrollPV.delegate = self;
    self.scrollPV = scrollPV;
    
    // 设置 tableView 的头视图为滚动视图
    self.tableView.tableHeaderView = scrollPV;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStyleGrouped];
    // 去掉系统分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 加载数据

//- (void)reloadHomeData {
    
    //[self loadHomeData];
    
    //[self loadRowsCellData];
    
//}

- (void)loadHomeData {
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
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

- (void)loadRowsCellData {
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:HOME_JINGPIN_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.apps = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"items"]];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error:%@", error);
        
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
    
    if (section == 0 || section == 2 || section == 3) {
        return 1;
    } else if (section == 1 || section == 5 || section == 6) {
        return 10;
    } else {
        return 1;
    }
}

// 每行的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3) {
        
        YKSingleRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YKSingleCellID];
        
        self.cell = cell;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (indexPath.section == 1 || indexPath.section == 5 || indexPath.section == 6) {
        YKRowsTableViewCell *cellRows = [tableView dequeueReusableCellWithIdentifier:YKRowsCellID];
        
        self.cellRows = cellRows;
        cellRows.app = self.apps[indexPath.row];
        cellRows.selectionStyle = UITableViewCellSelectionStyleNone;
        //cellRows.delegate = self;
        [cellRows.downBtn addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cellRows;
    }  else {
        YKOtherTableViewCell *cellOther = [tableView dequeueReusableCellWithIdentifier:YKOtherCellID];
        
        self.cellOther = cellOther;
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
    return 38;
}
// footer 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

// 每个 cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return 80;
    
    if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3) {
        
        return self.apps[indexPath.row].singleCellHeight;
        
    } else if (indexPath.section == 1 || indexPath.section == 5 || indexPath.section == 6) {
        return self.apps[indexPath.row].rowsCellHeight;
    } else {
        return self.cellOther.rowHeight;
    }
}
// 点击每一个 cell 的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 || indexPath.section == 5 || indexPath.section == 6) {
        //YKLog(@"呀,你点我了，我要有反应了");
        YKDetailViewController *detailVC = [[YKDetailViewController alloc] init];
        
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        
    }
}

#pragma mark - 监听

- (void)moreBtnClick:(UIButton *)button {
    
    NSInteger tag = button.tag;
    //YKLog(@"ttt = %zd", tag);
    
    YKMoreViewController *moreVC = [[YKMoreViewController alloc] init];
    moreVC.navTitle = self.homeData[tag].name;
    //moreVC.url = self.homeData[tag].act;
    moreVC.url = HOME_JINGPIN_URL;
    
    YKLog(@"url = %@", self.homeData[tag].act);
    
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)scrollPagingViewImageTapIndex:(NSInteger)index {
    
    YKMoreViewController *moreVC = [[YKMoreViewController alloc] init];
    moreVC.navTitle = self.scrollPV.ScrollImgArray[index].name;
    moreVC.url = self.scrollPV.ScrollImgArray[index].url;
    [self.navigationController pushViewController:moreVC animated:YES];
}

//- (void)rowsTableViewCell:(YKRowsTableViewCell *)cell {
    //YKLog(@"你点击了下载按钮");
//}

- (void)downBtnClick:(UIButton *)button {
    YKLogFunc
}

- (void)imgViewTapIndex:(NSInteger)index {
    YKMoreViewController *moreVC = [[YKMoreViewController alloc] init];
    moreVC.navTitle = self.cellOther.iconArray[index].name;
    moreVC.url = self.cellOther.iconArray[index].url;
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)showAppScrollViewImageTapIndex:(NSInteger)index {
    //YKLog(@"点击了cell中的app的某一个");
    YKDetailViewController *detailVC = [[YKDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}




@end








