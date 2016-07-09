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


@interface YKChatViewController ()

@property (nonatomic, strong) NSArray <YKChatCellModel *>*chatArray;

/** model */
//@property (nonatomic, strong) YKChatCellModel *model;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

@end

static NSString *const YKChatCellID = @"YKChatViewCell";

@implementation YKChatViewController

- (instancetype)init {
    if (self = [super init]) {
        
        
    }
    return self;
}

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupTableView];
}


- (void)setupTableView {
    self.tableView.backgroundColor = YKBaseBgColor;
    
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    [self.tableView registerClass:[YKChatViewCell class] forCellReuseIdentifier:YKChatCellID];
    
    self.tableView.mj_header = [XFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)getData {
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:CHAT_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.chatArray = [YKChatCellModel mj_objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error");
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"感兴趣的贴吧";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YKChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YKChatCellID];
    
    cell.model = self.chatArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.chatArray[indexPath.row].chatCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YKChatTwoViewController *chatTwo = [[YKChatTwoViewController alloc] init];
    
    chatTwo.url = self.chatArray[indexPath.row].act;
    chatTwo.navTitle = self.chatArray[indexPath.row].name;
    [self.navigationController pushViewController:chatTwo animated:YES];
}


@end







