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

@interface YKMoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView           *tableView;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager  *manager;


@property (nonatomic, strong) NSMutableArray <YKApp *>*apps;

/** lastpage */
@property (nonatomic, strong) NSMutableArray        *boolArray;
/** boo */
@property (nonatomic, strong) NSNumber              *lastPage;


@end


static NSString *const YKRowsCellID = @"YKRowsTableViewCell";

@implementation YKMoreViewController

#pragma mark - 懒加载

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
    
    [self firstLoadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupRefresh];
    });
}

- (void)setupNav {
    self.navigationItem.title = self.navTitle;
}

- (UIBarButtonItem *)creatNavBtnWithBackImage:(UIImage *)image action:(SEL)action {
    
    UIButton *button = [XFUtility xf_createBtnWithBackgroundImag:image];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] init];
    itme.customView = button;
    
    return itme;
}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStylePlain];
    // 去掉系统分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.tableView registerClass:[YKRowsTableViewCell class] forCellReuseIdentifier:YKRowsCellID];
}

// 第一次加载数据
- (void)firstLoadData {
    
    [SVProgressHUD showWithStatus:@"加载中,请稍候..."];
    
    [self loadNewData];
}

- (void)setupRefresh {
    self.tableView.mj_header = [XFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    if (![self.lastPage isEqualToNumber:@1]) {
        self.tableView.mj_footer = [XFRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
}

#pragma mark - 加载数据

- (void)loadNewData {
    
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.apps = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"items"]];
        
        weakSelf.lastPage = responseObject[@"Result"][@"atLastPage"];
        
        [weakSelf.tableView reloadData];
        
        [SVProgressHUD dismiss];
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error:%@", error);
        
        [SVProgressHUD showErrorWithStatus:@"加载失败,请稍候再试!"];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {
    
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
#warning 抓的 URL 需要参数才能加载下页,但不知道具体的传参要求,故加载的还是原有数据
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *moreArray = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"items"]];
        [weakSelf.apps addObjectsFromArray:moreArray];
        
        [weakSelf.tableView reloadData];
        
        [SVProgressHUD dismiss];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error:%@", error);
        
        [SVProgressHUD showErrorWithStatus:@"加载失败,请稍候再试!"];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - 事件监听

///**
 //*  YKRowsTableViewCell 代理方法
 //*/
//- (void)rowsTableViewCell:(YKRowsTableViewCell *)cell {
    //YKLog(@"你点击了下载按钮");
//}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKRowsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YKRowsCellID];
    cell.app = self.apps[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.downBtn addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.apps[indexPath.row].rowsCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //YKLog(@"你点击了莫一行");
    YKDetailViewController *detailVC = [[YKDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)downBtnClick:(UIButton *)button {
    YKLogFunc
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
