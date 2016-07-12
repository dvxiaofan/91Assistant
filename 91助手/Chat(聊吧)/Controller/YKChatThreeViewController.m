//
//  YKChatThreeViewController.m
//  91助手
//
//  Created by xiaofans on 16/7/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKChatThreeViewController.h"
#import "YKChatViewCell.h"
#import "YKChatCellModel.h"

@interface YKChatThreeViewController ()

@property (nonatomic, strong) NSArray *chatArray;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

/** model */
@property (nonatomic, strong) YKChatCellModel *model;

/** cell */
@property (nonatomic, strong) YKChatViewCell *cell;

@end

@implementation YKChatThreeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = YKGrayColor(236);
    self.navigationItem.title = self.navTitle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end









