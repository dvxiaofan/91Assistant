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


@interface YKHomeViewController ()<YKScrollPagingViewDelegate,UITableViewDelegate,UITableViewDataSource,YKSingleRowTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YKSingleRowTableViewCell *cell;

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

#pragma mark - YKScrollPagingView 代理方法

- (void)scrollPagingViewImageTapIndex:(NSInteger)index {
    YKLog(@"点击了表格顶部滚动图片--%ld",(long)index);
    
}

#pragma mark - 创建TableView
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN.width * 7 / 16, SCREEN.width, SCREEN.height - NAVBAR_HEIGHT - TABBAR_HEIGHT - SCREEN.width * 7 / 16) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableView 代理方法
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

// 每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 1;
    } else if (section == 4) {
        return 2;
    } else if (section == 5) {
        return 2;
    } else {
        return 4;
    }
}

// 每个分区的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN.width - 30, 35)];
    label.font = CELL_NAME_FONT;
    [headerView addSubview:label];
    
    // 更多 按钮
    UIButton *moreBtn = [[UIButton alloc] init];
    CGFloat moreBtnX = SCREEN.width - 60;
    CGFloat moreBtnY = 10;
    CGFloat moreBtnW = 25;
    CGFloat moreBtnH = 16;
    moreBtn.frame = CGRectMake(moreBtnX, moreBtnY, moreBtnW, moreBtnH);
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setBackgroundColor:[UIColor clearColor]];
    moreBtn.titleLabel.font = CELL_BTN_FONT;
    [moreBtn setTitleColor:CELL_BTN_COLOR forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:moreBtn];
    
    UIImageView *btnLabel = [[UIImageView alloc] init];
    CGFloat btnLabelX = CGRectGetMaxX(moreBtn.frame);
    CGFloat btnLabelY = 13;
    CGFloat btnLabelW = 12;
    CGFloat btnLabelH = 10;
    btnLabel.frame = CGRectMake(btnLabelX, btnLabelY, btnLabelW, btnLabelH);
    btnLabel.image = [UIImage imageNamed:@"web_next_nor"];
    btnLabel.clipsToBounds = YES;
    [headerView addSubview:btnLabel];
    
    switch (section) {
        case 0:
            label.text = @"热门应用";
            break;
        case 1:
            label.text = @"精品推荐";
            break;
        case 2:
            label.text = @"限时免费";
            break;
        case 3:
            label.text = @"装机必备";
            break;
        case 4:
            label.text = @"应用专题";
            break;
        case 5:
            label.text = @"黑马闯入";
            break;
        case 6:
            label.text = @"编辑推荐";
            break;
    }
    
    return headerView;
}

// 分区头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"hello";
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
    } else {
        YKSingleRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItwo"];
        if (!cell) {
            cell = [[YKSingleRowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIDtwo"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        return cell;
        
    }
    
}

//每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return 80;
    
    if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3) {
        
        return self.cell.SingleRowCellHeight;
        
    } else if (indexPath.section == 1) {
        return 80;
        
    } else if (indexPath.section == 4) {
        return 80;
        
    } else if (indexPath.section == 5) {
        return 80;
        
    } else {
        return 80;
        
    }
}

#pragma mark - section 头部视图总 更多按钮的点击事件
- (void)btnClick:(UIButton *)button {
    YKLog(@"点击了 更多 按钮");
    
}

#pragma mark - YKSingleRowTableViewCell 代理事件 

- (void)showAppScrollViewImageTapIndex:(NSInteger)index {
    YKLog(@"点击了cell中的app--%ld", (long)index);
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
