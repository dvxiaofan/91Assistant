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


@interface YKHomeViewController ()<YKScrollPagingViewDelegate,UITableViewDelegate,UITableViewDataSource,YKSingleRowTableViewCellDelegate,YKRowsTableViewCellDelegate,YKOtherTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YKSingleRowTableViewCell *cell;

@property (nonatomic, strong) YKRowsTableViewCell *cellRows;

@property (nonatomic, strong) YKOtherTableViewCell *cellOther;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) NSMutableArray *sectionNameArray;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray <YKApp *>*apps;



@end

static NSString *const YKSingleCellID = @"YKSingleRowTableViewCell";
static NSString *const YKRowsCellID = @"YKRowsTableViewCell";
static NSString *const YKOtherCellID = @"YKOtherTableViewCell";

@implementation YKHomeViewController

#pragma mark - 懒加载

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

//- (NSMutableArray *)SectionNameArray {
    //if (!_SectionNameArray) {
        //_SectionNameArray = [NSMutableArray array];
    //}
    //return _SectionNameArray;
//}
#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"9 1助手";
    
    // 创建TableView
    [self setupTableView];
    
    // 创建头部滚动视图
    [self setupScrollView];
    
    NSMutableArray *sectionNameArray = [NSMutableArray array];
    self.sectionNameArray = sectionNameArray;
    
    NSMutableArray *singleRowAppNameArray = [NSMutableArray array];
    self.singleRowAppNameArray = singleRowAppNameArray;
    
    
    
    [self setupRefresh];
}

- (void)setupScrollView {
    
    YKScrollPagingView *scrollPV = [[YKScrollPagingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.width * 7 / 16)];
    [scrollPV setImageView];
    // 设置代理
    scrollPV.delegate = self;
    
    // 设置 tableView 的头视图为滚动视图
    self.tableView.tableHeaderView = scrollPV;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[YKSingleRowTableViewCell class] forCellReuseIdentifier:YKSingleCellID];
    [tableView registerClass:[YKRowsTableViewCell class] forCellReuseIdentifier:YKRowsCellID];
    [tableView registerClass:[YKOtherTableViewCell class] forCellReuseIdentifier:YKOtherCellID];
}

- (void)setupRefresh {
    self.tableView.mj_header = [XFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRowsCellData)];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 加载数据

//- (void)reloadTabelView {
    
    //[self loadRowsCellData];
    
//}

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

//- (void)loadNewData {
    //// 取消所有请求
    //[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    //__weak typeof(self) weakSelf = self;
    
    //[self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //YKLog(@"success");
        
        
        //XFWriteToPlist(responseObject, @"hotapp2");
        
        
        //[weakSelf.tableView reloadData];
        
        //[weakSelf.tableView.mj_header endRefreshing];
        
    //} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //YKLog(@"error:%@", error);
        //[weakSelf.tableView.mj_header endRefreshing];
    //}];
//}

#pragma mark - <UITableViewDataSource>

// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
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
        cellRows.delegate = self;
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
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, SCREEN.width - 30, 20)];
    titleLabel.font = CELL_NAME_FONT;
    switch (section) {
        case 0:
            titleLabel.text = @"热门应用";
            break;
        case 1:
            titleLabel.text = @"精品推荐";
            break;
        case 2:
            titleLabel.text = @"限时免费";
            break;
        case 3:
            titleLabel.text = @"装机必备";
            break;
        case 4:
            titleLabel.text = @"应用专题";
            break;
        case 5:
            titleLabel.text = @"黑马闯入";
            break;
        case 6:
            titleLabel.text = @"编辑推荐";
            break;
    }
    
    [headerView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *moreBtn = [[UIButton alloc] init];
    moreBtn.frame = CGRectMake(SCREEN.width - 60, 12, 25, 16);
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setBackgroundColor:[UIColor clearColor]];
    moreBtn.titleLabel.font = CELL_BTN_FONT;
    [moreBtn setTitleColor:CELL_BTN_COLOR forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(CGRectGetMaxX(moreBtn.frame), 15, 12, 10);
    imgView.image = [UIImage imageNamed:@"web_next_nor"];
    imgView.clipsToBounds = YES;
    [headerView addSubview:imgView];
    
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
    
    YKMoreViewController *moreVC = [[YKMoreViewController alloc] init];
    
    
    moreVC.navTitle = @"热门应用";
    
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)scrollPagingViewImageTapIndex:(NSInteger)index {
    YKMoreViewController *moreVC = [[YKMoreViewController alloc] init];
    
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)rowsTableViewCell:(YKRowsTableViewCell *)cell {
    YKLog(@"你点击了下载按钮");
}

- (void)imgViewTapIndex:(NSInteger)index {
    //YKLog(@"点击了四张图中的某一张");
    YKMoreViewController *moreVC = [[YKMoreViewController alloc] init];
    
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)showAppScrollViewImageTapIndex:(NSInteger)index {
    //YKLog(@"点击了cell中的app的某一个");
    YKDetailViewController *detailVC = [[YKDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}



@end








