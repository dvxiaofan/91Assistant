//
//  YKChatTwoViewController.m
//  91助手
//
//  Created by xiaofans on 16/6/29.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKChatTwoViewController.h"
#import "YKChatViewCell.h"
#import "YKChatTwoModel.h"
#import "YKChatCellModel.h"
#import "YKChatThreeViewController.h"


@interface YKChatTwoViewController ()

@property (nonatomic, strong) NSArray *chatArray;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

/** model */
@property (nonatomic, strong) YKChatCellModel *model;

/** cell */
@property (nonatomic, strong) YKChatViewCell *cell;

@end

@implementation YKChatTwoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navTitle;
    
    [SVProgressHUD showWithStatus:@"加载中,请稍候..."];
    
    [[AFHTTPSessionManager manager] GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.chatArray = [YKChatCellModel mj_objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍候再试"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.chatArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *chatCellID = @"YKChatViewCell";
    
    YKChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chatCellID];
    if (!cell) {
        cell = [[YKChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chatCellID];
    }
    self.cell = cell;
    self.model = self.chatArray[indexPath.row];
    cell.nameLabel.text = self.model.name;
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.model.icon] placeholderImage:[UIImage imageNamed:@"avatar_ba_defaul140"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cell.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YKChatThreeViewController *chatThree = [[YKChatThreeViewController alloc] init];
    self.model = self.chatArray[indexPath.row];
    chatThree.url = self.model.act;
    chatThree.navTitle = self.model.name;
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
