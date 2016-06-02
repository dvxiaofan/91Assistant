//
//  YKHomeViewController.m
//  91助手
//
//  Created by xiaofan on 16/5/30.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKHomeViewController.h"
#import "YKScrollPagingView.h"

@interface YKHomeViewController ()<YKScrollPagingViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"9 1助手";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupTableView];
    
    [self setupScrollView];
    
    
    
}


#pragma mark - 设置顶部滚动视图
- (void)setupScrollView {
    
    YKScrollPagingView *scrollPV = [[YKScrollPagingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height * 4.5 / 16)];
    scrollPV.backgroundColor = [UIColor yellowColor];
    [scrollPV setImageView];
    // 设置代理
    scrollPV.delegate = self;
    
    // 设置 tableView 的头视图为滚动视图
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.width * 4.5 / 16)];
    [self.tableView.tableHeaderView addSubview:scrollPV];
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN.width, SCREEN.height - NAVBAR_HEIGHT - TABBAR_HEIGHT);
    
}

#pragma mark - YKScrollPagingView 代理方法

- (void)scrollPagingViewImageTapIndex:(NSInteger)index {
    YKLog(@"点击的图片索引是---%ld",(long)index);
    
}

#pragma mark - 创建TableView
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN.width * 4.5 / 16, SCREEN.width, SCREEN.height - NAVBAR_HEIGHT - TABBAR_HEIGHT - SCREEN.width * 4.5 / 16) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark - UITableView 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"xiaofan";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
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
