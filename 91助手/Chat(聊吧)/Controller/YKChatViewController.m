//
//  YKChatViewController.m
//  91助手
//
//  Created by xiaofan on 16/5/30.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKChatViewController.h"
#import "YKChatViewCell.h"
#import "YKChatCellModel.h"
#import "YKChatTwoViewController.h"


static NSString * const cellID = @"cellID";

@interface YKChatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *chatArray;

@property (nonatomic, strong) UITableView *tableView;

/** model */
@property (nonatomic, strong) YKChatCellModel *model;

@end

@implementation YKChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self getData];
    
    [self setupTableView];
}

- (void)getData {
    [SVProgressHUD showWithStatus:@"加载中,请稍候..."];
    
    [[AFHTTPSessionManager manager] GET:CHAT_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.chatArray = [YKChatCellModel mj_objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error");
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍候再试"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height - 110) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    //tableView.backgroundColor = YKRandomColor;
    
    [tableView registerClass:[YKChatViewCell class] forCellReuseIdentifier:cellID];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 28;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"感兴趣的贴吧";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YKChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    //if (!cell) {
        //cell = [[YKChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    //}
    
    self.model = self.chatArray[indexPath.row];
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.model.icon] placeholderImage:[UIImage imageNamed:@"avatar_ba_defaul80"]];
    cell.nameLabel.text = self.model.name;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKChatViewCell *cell = [[YKChatViewCell alloc] init];
    return cell.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YKChatTwoViewController *chatTwo = [[YKChatTwoViewController alloc] init];
     self.model = self.chatArray[indexPath.row];
    chatTwo.url = self.model.act;
    chatTwo.navTitle = self.model.name;
    [self.navigationController pushViewController:chatTwo animated:YES];
}


@end







