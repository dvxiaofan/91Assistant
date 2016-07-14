//
//  YKSearchButtons.m
//  91助手
//
//  Created by xiaofans on 16/7/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSearchButtons.h"

#define BTN_BASE_TAG 100

@interface YKSearchButtons ()

/** titles */
@property (nonatomic, strong) NSArray *titleArray;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

/** 热门搜索 */
@property (nonatomic, weak) UILabel *hotSearchLabel;

@end


@implementation YKSearchButtons

#pragma mark - 懒加载

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBtnData];
    }
    return self;
}

- (void)loadBtnData {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:SEARCH_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.titleArray = responseObject[@"Result"];
        
        [self setViewWithArray:weakSelf.titleArray];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error");
    }];
}

- (void)setViewWithArray:(NSArray *)titleArray {
    
    UILabel *hotSearchLabel = [[UILabel alloc] init];
    hotSearchLabel.frame = CGRectMake(YKMargin, YKSmallMargin, 100, 20);
    hotSearchLabel.text = @"热门搜索";
    hotSearchLabel.font = [UIFont boldSystemFontOfSize:17.0];
    hotSearchLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:hotSearchLabel];
    self.hotSearchLabel = hotSearchLabel;
    
    /*** 创建按钮  */
    int maxColosCount = 4;  // 一行的最大列数
    
    CGFloat btnW = (SCREEN.width - YKMargin * 3 - YKSmallMargin) / maxColosCount;
    CGFloat btnH = 30;
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        
        UIButton *sButton = [[UIButton alloc] init];
        
        sButton.xf_x = YKMargin + (YKSmallMargin + btnW)  * (i % 4);
        sButton.xf_y = CGRectGetMaxY(self.hotSearchLabel.frame) + YKSmallMargin + (btnH + YKSmallMargin) * (i / 4);
        sButton.xf_width =  btnW;
        sButton.xf_height = btnH;
        
        sButton.backgroundColor = YKRandomColor;
        sButton.tag = BTN_BASE_TAG + i;
        [sButton setTitle:titleArray[i] forState:UIControlStateNormal];
        sButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [sButton setTitleColor:YKTextBlackColor forState:UIControlStateNormal];
        
        [sButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:sButton];
        self.sButton = sButton;
    }
}

- (void)btnClick:(UIButton *)button {
    NSInteger tag = button.tag - BTN_BASE_TAG;
    YKLog(@"快速搜索 - %@", self.titleArray[tag]);
    
}



@end














