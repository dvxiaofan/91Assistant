//
//  YKDetailSingelScrollCell.m
//  91助手
//
//  Created by xiaofans on 16/7/14.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKDetailSingelScrollCell.h"
#import "YKDetailModel.h"
#import <UIButton+WebCache.h>
#import "YKDetailViewController.h"


#define kBtnBaseTag 100

@interface YKDetailSingelScrollCell ()

/** ingo */
@property (nonatomic, weak) UILabel *infoLabel;

/** iconBtn */
@property (nonatomic, weak) UIButton *iconBtn;

/** appArray */
@property (nonatomic, strong) NSArray *appArray;

@end

@implementation YKDetailSingelScrollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = YKBaseBgColor;
    }
    return self;
}
- (void)createCellWithModel:(YKDetailModel *)model {
//- (void)creatView {
    
    // section 标题
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.frame = CGRectMake(YKMargin, YKSmallMargin, SCREEN.width - YKMargin * 2, YKMargin);
    
    infoLabel.text = @"下载此应用的人也下载了";
    infoLabel.textColor = YKTextBlackColor;
    infoLabel.font = YKTextBoldFont;
    
    [self addSubview:infoLabel];
    self.infoLabel = infoLabel;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.xf_x = YKSmallMargin;
    scrollView.xf_y = CGRectGetMaxY(infoLabel.frame);
    scrollView.xf_width = SCREEN.width - YKMargin;
    scrollView.xf_height = YKAppWH + YKMargin * 2;
    
    [self addSubview:scrollView];
    
    self.appArray = model.recommendSofts;
    
    for (NSInteger i = 0; i < self.appArray.count; i++) {
        UIButton *iconBtn = [[UIButton alloc] init];
        iconBtn.xf_width = YKAppWH;
        iconBtn.xf_height = YKAppWH;
        iconBtn.xf_x = YKSmallMargin + (iconBtn.xf_width + YKMargin + YKSmallSpace) * i;
        iconBtn.xf_y = YKSmallMargin;
        
        [iconBtn sd_setImageWithURL:[NSURL URLWithString:self.appArray[i][@"icon"]] forState:UIControlStateNormal];
        iconBtn.layer.cornerRadius = 5.0;
        iconBtn.clipsToBounds = YES;
        iconBtn.tag = kBtnBaseTag + i;
        
        [iconBtn addTarget:self action:@selector(appClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:iconBtn];
        self.iconBtn = iconBtn;
    }
    
    scrollView.contentSize = CGSizeMake(((YKMargin + YKSmallMargin) * (self.appArray.count - 1) + self.iconBtn.xf_width * self.appArray.count), YKAppWH + YKMargin);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    self.cellHeight = CGRectGetMaxY(infoLabel.frame) + scrollView.xf_height;
    
    
}

/**
 *  设置顶部分割线
 */
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    frame.origin.y += 1;
    
    [super setFrame:frame];
}

#pragma mark - 事件监听

- (void)appClick:(UIButton *)button {
    NSInteger tag = button.tag - kBtnBaseTag;
    
    // 获得当前页面的导航控制器
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tabBarVC.selectedViewController;
    
    YKDetailViewController *detailVC = [[YKDetailViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.url = self.appArray[tag][@"detailUrl"];
    
    [nav pushViewController:detailVC animated:YES];
    
    
}




@end


















