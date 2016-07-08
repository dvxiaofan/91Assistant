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


static NSString * const cellID = @"cellID";

@interface YKChatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *chatArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YKChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self getData];
    
    [self setupTableView];
    
    
    
}

- (void)getData {
    [[AFHTTPSessionManager manager] GET:CHAT_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.chatArray = [YKChatCellModel mj_objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        
        //YKLog(@"count = %zd", self.chatArray.count);
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error");
    }];
}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height - 60) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    //tableView.backgroundColor = YKRandomColor;
    
    //[tableView registerClass:[YKChatViewCell class] forCellReuseIdentifier:cellID];
    
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
    
    if (!cell) {
        cell = [[YKChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    YKChatCellModel *model = self.chatArray[indexPath.row];
    YKLog(@"model = %@", model);
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"avatar_ba_defaul80"]];
    cell.nameLabel.text = model.name;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKChatViewCell *cell = [[YKChatViewCell alloc] init];
    return cell.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YKLogFunc
}


@end







