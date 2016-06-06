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
#import "YKTenRowsTableViewCell.h"
#import "YKOtherTableViewCell.h"
#import "YKSectionHeaderView.h"


@interface YKHomeViewController ()<YKScrollPagingViewDelegate,UITableViewDelegate,UITableViewDataSource,YKSingleRowTableViewCellDelegate,YKTenRowsTableViewCellDelegate,YKOtherTableViewCellDelegate,YKSectionHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YKSingleRowTableViewCell *cell;

@property (nonatomic, strong) YKTenRowsTableViewCell *cellTwo;

@property (nonatomic, strong) YKOtherTableViewCell *cellOther;

@property (nonatomic, strong) YKSectionHeaderView *headerView;

@end

@implementation YKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"9 1助手";
    
    // 创建TableView
    [self setupTableView];
    
    // 创建头部滚动视图
    [self setupScrollView];
    
}

#pragma mark - 设置顶部滚动视图

- (void)setupScrollView {
    
    YKScrollPagingView *scrollPV = [[YKScrollPagingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.width * 7 / 16)];
    [scrollPV setImageView];
    // 设置代理
    scrollPV.delegate = self;
    
    // 设置 tableView 的头视图为滚动视图
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.width * 7 / 16)];
    [self.tableView.tableHeaderView addSubview:scrollPV];
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN.width, SCREEN.height);
}

#pragma mark - 创建TableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN.width * 7 / 16, SCREEN.width, SCREEN.height - NAVBAR_HEIGHT - TABBAR_HEIGHT - SCREEN.width * 7 / 16) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - 分区的头视图

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YKSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerview"];
    if (!headerView) {
        headerView = [[YKSectionHeaderView alloc] initWithReuseIdentifier:@"headerview"];
    }
    self.headerView = headerView;
    headerView.delegate = self;
    
    switch (section) {
        case 0:
            headerView.text = @"热门应用";
            break;
        case 1:
            headerView.text = @"精品推荐";
            break;
        case 2:
            headerView.text = @"限时免费";
            break;
        case 3:
            headerView.text = @"装机必备";
            break;
        case 4:
            headerView.text = @"应用专题";
            break;
        case 5:
            headerView.text = @"黑马闯入";
            break;
        case 6:
            headerView.text = @"编辑推荐";
            break;
    }
    
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

#pragma mark - UITableView 代理方法
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
        
        YKSingleRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[YKSingleRowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        }
        self.cell = cell;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (indexPath.section == 1 || indexPath.section == 5 || indexPath.section == 6) {
        YKTenRowsTableViewCell *cellTwo = [tableView dequeueReusableCellWithIdentifier:@"cellTwo"];
        if (!cellTwo) {
            cellTwo = [[YKTenRowsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTwo"];
        }
        self.cellTwo = cellTwo;
        cellTwo.selectionStyle = UITableViewCellSelectionStyleNone;
        cellTwo.delegate = self;
        return cellTwo;
    } else {
        YKOtherTableViewCell *cellOther = [tableView dequeueReusableCellWithIdentifier:@"cellOther"];
        if (!cellOther) {
            cellOther = [[YKOtherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOther"];
        }
        self.cellOther = cellOther;
        cellOther.selectionStyle = UITableViewCellSelectionStyleNone;
        cellOther.delegate = self;
        return cellOther;
        
    }
}

// 每个 cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return 80;
    
    if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3) {
        
        return self.cell.rowHeight;
        
    } else if (indexPath.section == 1 || indexPath.section == 5 || indexPath.section == 6) {
        return self.cellTwo.rowHeight;
    } else {
        return self.cellOther.rowHeight;
    }
}
// 点击每一个 cell 的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 || indexPath.section == 5 || indexPath.section == 6) {
        YKLog(@"呀,你点我了，我要有反应了");
    } else {
        
    }
}

#pragma mark - YKScrollPagingView 代理方法

- (void)scrollPagingViewImageTapIndex:(NSInteger)index {
    YKLog(@"点击了表格顶部滚动图片的第-%ld-张",(long)index + 1);
    
}

#pragma mark - YKTenRowsTableViewCell 代理方法

- (void)tenRowsTableViewCell:(YKTenRowsTableViewCell *)cell {
    YKLog(@"你点击了下载按钮");
}

#pragma mark - YKOtherTableViewCell 代理方法

- (void)imgViewTapIndex:(NSInteger)index {
    YKLog(@"点击了四张图中的第-%d-张", index + 1);
}

#pragma mark - YKSingleRowTableViewCell 代理事件 

- (void)showAppScrollViewImageTapIndex:(NSInteger)index {
    YKLog(@"点击了cell中的app的第-%ld-个", (long)index + 1);
}

#pragma mark - YKSectionHeaderView.h 代理事件

- (void)sectionHeaderView:(YKSectionHeaderView *)view {
    YKLog(@"点击了更多按钮");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
