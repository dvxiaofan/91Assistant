//
//  YKSingleRowTableViewCell.m
//  91助手
//
//  Created by xiaofan on 16/6/3.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSingleRowTableViewCell.h"
#import "YKApp.h"
#import "YKDetailViewController.h"



#define APP_NAME_FONT [UIFont systemFontOfSize:11.0]
#define APP_NAME_COLOR [UIColor blackColor]

#define ICON_TAG 100

@interface YKSingleRowTableViewCell ()

@property (nonatomic, weak) UIScrollView *showAppSV;  // 显示app的滚动视图
@property (nonatomic, weak) UIImageView *iconView;    // APP 图标
@property (nonatomic, weak) UILabel *appNameLabel;    // APP 名字
/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

/**  */
@property (nonatomic, strong) YKApp *singleRowApp;

@end

@implementation YKSingleRowTableViewCell

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

/**
 *  初始化
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadNewData];
    }
    return self;
}

- (void)loadNewData {
    // 取消所有请求
    //[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    __weak typeof(self) weakSelf = self;
    
    
    [self.manager GET:HOME_HOT_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //YKLogFunc
        
        NSArray *singleRowApps = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"items"]];
        
        [weakSelf createApp:singleRowApps];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error:%@", error);
        
    }];
}

#pragma mark - UI布局

- (void)createApp:(NSArray *)singleRowApps {
    
    NSInteger count = singleRowApps.count;
    
    // 滚动视图
    UIScrollView *showAppSV = [[UIScrollView alloc] init];
    CGFloat svX = YKMargin;
    CGFloat svW = SCREEN.width - svX * 2;
    showAppSV.frame = CGRectMake(svX, 5, svW, 90);
    [self addSubview:showAppSV];
    self.showAppSV = showAppSV;
    
    for (int i = 0; i < count; i ++) {
        _singleRowApp = singleRowApps[i];
        
        UIImageView *iconView = [[UIImageView alloc] init];
        CGFloat imgViewX = i * YKAppWH + YKMargin * i;
        CGFloat imgViewY = YKSmallMargin;
        iconView.frame = CGRectMake(imgViewX, imgViewY, YKAppWH, YKAppWH);
        [iconView xf_setRectHeaderWithUrl:self.singleRowApp.icon placeholder:@"icon-29"];
        iconView.clipsToBounds = YES;
        iconView.layer.cornerRadius = 8.0;
        [showAppSV addSubview:iconView];
        self.iconView = iconView;
        iconView.tag = ICON_TAG + i;
        iconView.userInteractionEnabled = YES;
        
        // 增加点击手势识别
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIcon:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [iconView addGestureRecognizer:tap];
        
        // app名字
        UILabel *appNameLebal = [[UILabel alloc] init];
        CGFloat appNameY = CGRectGetMaxY(iconView.frame) + 8;
        appNameLebal.frame = CGRectMake(imgViewX, appNameY, YKAppWH, 10);
        appNameLebal.text = self.singleRowApp.name;
        appNameLebal.font = APP_NAME_FONT;
        appNameLebal.textColor = APP_NAME_COLOR;
        appNameLebal.textAlignment = NSTextAlignmentCenter;
        [showAppSV addSubview:appNameLebal];
        self.appNameLabel = appNameLebal;
        
    }
    showAppSV.contentSize = CGSizeMake(self.iconView.frame.size.width * count + YKMargin * (count - 1), 0);
    showAppSV.showsHorizontalScrollIndicator = NO;
}

#pragma mark - APP 点击事件
- (void)tapIcon:(UITapGestureRecognizer *)sender {
    // 获得当前页面的导航控制器
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tabBarVC.selectedViewController;
    
    YKDetailViewController *detailVC = [[YKDetailViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.url = self.singleRowApp.detailUrl;
    [nav pushViewController:detailVC animated:YES];
}




@end














