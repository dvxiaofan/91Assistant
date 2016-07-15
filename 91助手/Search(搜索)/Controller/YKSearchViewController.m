//
//  YKSearchViewController.m
//  91助手
//
//  Created by xiaofan on 16/5/30.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSearchViewController.h"
#import "YKSearchButtons.h"

@interface YKSearchViewController ()<UISearchBarDelegate>

/** search */
@property (nonatomic, strong) UISearchBar *searchBar;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

@end

@implementation YKSearchViewController

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
    
    [self setupSearchBar];
    
    [self setupView];
}

- (void)setupSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"搜索";
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.showsCancelButton = NO;
    searchBar.delegate = self;
    self.searchBar = searchBar;
    
    self.navigationItem.titleView = searchBar;
}

- (void)setupView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.userInteractionEnabled = YES;
    
    YKSearchButtons *btnView = [[YKSearchButtons alloc] init];
    btnView.frame = self.view.bounds;
    
    [self.view addSubview:btnView];
}

#pragma mark - 搜索框代理事件
// 开始编辑搜索框
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    searchBar.showsCancelButton = YES;
    
    NSArray *subViews = [(searchBar.subviews[0]) subviews];
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}

#pragma mark - 事件监听

// 点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    YKLog(@"点击搜索");
}
// 点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}


@end


















