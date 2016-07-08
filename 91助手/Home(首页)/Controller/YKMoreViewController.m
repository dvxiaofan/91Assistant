//
//  YKMoreViewController.m
//  91助手
//
//  Created by xiaofan on 16/6/7.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKMoreViewController.h"
#import "YKRowsTableViewCell.h"
#import "YKDetailViewController.h"
#import "YKApp.h"

@interface YKMoreViewController ()<UITableViewDelegate, UITableViewDataSource, YKRowsTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YKRowsTableViewCell *cell;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;


@property (nonatomic, strong) NSMutableArray <YKApp *>*apps;

@end


static NSString *const YKRowsCellID = @"YKRowsTableViewCell";

@implementation YKMoreViewController

#pragma mark - 懒加载

- (XFHTTPSessionManager *)manager {
    if (_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
    
    [self setupRefresh];
}

- (void)setupNav {
    self.navigationItem.title = self.navTitle;
    self.navigationItem.leftBarButtonItem = [self creatNavBtnWithBackImage:[UIImage imageNamed:@"bar_back_normal"] action:@selector(actionBack:)];
}

- (UIBarButtonItem *)creatNavBtnWithBackImage:(UIImage *)image action:(SEL)action {
    
    UIButton *button = [YKUtility createBtnWithBackgroundImag:image];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] init];
    itme.customView = button;
    
    return itme;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.tableView registerClass:[YKRowsTableViewCell class] forCellReuseIdentifier:YKRowsCellID];
}

- (void)setupRefresh {
    self.tableView.mj_header = [XFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTabelView)];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 加载数据

- (void)reloadTabelView {
    
    [self loadRowsCellData];
    
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)loadRowsCellData {
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.apps = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"tiems"]];
        YKLog(@"cc = %zd", weakSelf.apps.count);
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error:%@", error);
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}


#pragma mark - 事件监听
// 返回按钮
- (void)actionBack:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  YKRowsTableViewCell 代理方法
 */
- (void)rowsTableViewCell:(YKRowsTableViewCell *)cell {
    YKLog(@"你点击了下载按钮");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKRowsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YKRowsCellID];
    cell.apps = self.apps[indexPath.row];
    cell.backgroundColor = [UIColor orangeColor];
    //cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cell = cell;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cell.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //YKLog(@"你点击了莫一行");
    YKDetailViewController *detailVC = [[YKDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
