//
//  YKChatTwoViewController.m
//  91助手
//
//  Created by xiaofans on 16/6/29.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKChatTwoViewController.h"
#import "YKChatViewCell.h"
#import "YKChatCellModel.h"
#import "YKChatThreeViewController.h"


@interface YKChatTwoViewController ()

@property (nonatomic, strong) NSArray <YKChatCellModel *>*chatArray;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

@end

static NSString *const YKChatCellID = @"YKChatViewCell";

@implementation YKChatTwoViewController

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navTitle;
    
    [self setupTableView];
}


- (void)setupTableView {
    self.tableView.backgroundColor = YKGrayColor(236);
    
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    [self.tableView registerClass:[YKChatViewCell class] forCellReuseIdentifier:YKChatCellID];
    
    self.tableView.mj_header = [XFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadData {
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.chatArray = [YKChatCellModel mj_objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍候再试"];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}

#pragma mark - Table view data source}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.chatArray.count;
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
    YKChatThreeViewController *chatThree = [[YKChatThreeViewController alloc] init];
    chatThree.url = self.chatArray[indexPath.row].act;
    chatThree.navTitle = self.chatArray[indexPath.row].name;
    [self.navigationController pushViewController:chatThree animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
