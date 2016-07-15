//
//  YKDetailHeaderView.m
//  91助手
//
//  Created by xiaofans on 16/7/13.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKDetailHeaderView.h"
#import "YKStarView.h"
#import "NSString+YKExtension.h"
#import "YKDetailModel.h"
#import "XFWebViewController.h"
#import "YKDownViewController.h"


@interface YKDetailHeaderView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
/** 快照 */
@property (nonatomic, weak) UIImageView *scrImageView;
/** iconView */
@property (nonatomic, weak) UIImageView *iconView;
/** nameLabel */
@property (nonatomic, weak) UILabel *nameLabel;
/** filesize */
@property (nonatomic, weak) UILabel *fileSizeLabel;
/** 版本号 */
@property (nonatomic, weak) UILabel *versionLabel;
/** down */
@property (nonatomic, weak) UIButton *downButton;
/** open */
@property (nonatomic, weak) UIButton *openChatBtn;

/** star */
@property (nonatomic, strong) YKStarView *starView;

/** mmm */
@property (nonatomic, strong) YKDetailModel *model;


@end

@implementation YKDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = YKBaseBgColor;
    }
    return self;
}


- (void)createViewWithModel:(YKDetailModel *)model {
    _model = model;
    // 滚动快照视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, SCREEN.width, 250);
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    NSArray *imageArray = model.snapshots;
    NSMutableArray *newImageArray = [NSMutableArray array];
    [newImageArray addObjectsFromArray:imageArray];
    
    if (newImageArray.count % 2 == 1) {
        [newImageArray addObject:imageArray.firstObject];
    }
    for (NSInteger i = 0; i < newImageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.xf_x = i * (SCREEN.width / 2) + 2 * (i % 2);
        imageView.xf_y = 0;
        imageView.xf_width = SCREEN.width / 2 - 2;
        imageView.xf_height = self.scrollView.xf_height;
        [imageView sd_setImageWithURL:[NSURL URLWithString:newImageArray[i]] placeholderImage:[UIImage imageNamed:@"detail_image_default"]];
        [self.scrollView addSubview:imageView];
        
    }
    scrollView.contentSize = CGSizeMake(newImageArray.count / 2 * SCREEN.width, self.scrollView.xf_height);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    
    // icon
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.frame = CGRectMake(YKMargin, (CGRectGetMaxY(self.scrollView.frame) - 33), 65, 65);
    
    [iconView xf_setRectHeaderWithUrl:model.icon placeholder:@"avatar_poto_defaul140"];
    
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // 名字
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.xf_x = CGRectGetMaxX(self.iconView.frame) + YKSmallMargin;
    nameLabel.xf_y = self.iconView.xf_y + YKSmallMargin;
    nameLabel.xf_width = SCREEN.width - self.iconView.xf_width - YKMargin * 2;
    nameLabel.xf_height = YKMargin;
    
    nameLabel.text = model.name;
    nameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    nameLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 星级评价
    YKStarView *starView = [[YKStarView alloc] init];
    starView.xf_x = nameLabel.xf_x;
    starView.xf_y = CGRectGetMaxY(nameLabel.frame) + YKSmallMargin;
    starView.xf_width = 100;
    starView.xf_height = 15;
    
    starView.showStar = [model.star intValue] * 20;
    
    [self addSubview:starView];
    self.starView = starView;
    
    // 大小
    UILabel *fileSizeLabel = [[UILabel alloc] init];
    CGFloat size = [model.size doubleValue] / 1024 / 1024;
    fileSizeLabel.text = [NSString stringWithFormat:@"大小: %.2fMB", size];;
    fileSizeLabel.font = [UIFont systemFontOfSize:12.0];
    fileSizeLabel.textColor = [UIColor grayColor];
    
    fileSizeLabel.xf_x = starView.xf_x;
    fileSizeLabel.xf_y = CGRectGetMaxY(starView.frame);
    CGSize fileSize = [fileSizeLabel.text xf_sizeWithFont:fileSizeLabel.font];
    fileSizeLabel.xf_width = fileSize.width;
    fileSizeLabel.xf_height = fileSize.height;
    
    [self addSubview:fileSizeLabel];
    self.fileSizeLabel = fileSizeLabel;
    
    // 版本
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.text = [NSString stringWithFormat:@"版本: %@", model.versionCode];
    versionLabel.font = [UIFont systemFontOfSize:12.0];
    versionLabel.textColor = [UIColor grayColor];
    
    versionLabel.xf_x = CGRectGetMaxX(fileSizeLabel.frame) + 3;
    versionLabel.xf_y = fileSizeLabel.xf_y;
    CGSize versionSize = [versionLabel.text xf_sizeWithFont:versionLabel.font];
    versionLabel.xf_width = versionSize.width;
    versionLabel.xf_height = versionSize.height;
    
    [self addSubview:versionLabel];
    self.versionLabel = versionLabel;
    
    // 下载按钮
    UIButton *downButton = [[UIButton alloc] init];
    downButton.xf_x = SCREEN.width - YKMargin * 4;
    downButton.xf_y = CGRectGetMaxY(nameLabel.frame) + YKSmallMargin;
    downButton.xf_width = YKMargin * 3 + YKSmallSpace;
    downButton.xf_height = 25;
    downButton.backgroundColor = [UIColor orangeColor];
    downButton.layer.cornerRadius = 3.0;
    downButton.clipsToBounds = YES;
    [downButton addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([model.price isEqualToString:@"0.00"]) {
        [downButton setTitle:@"免费" forState:UIControlStateNormal];
    } else {
        [downButton setTitle:model.price forState:UIControlStateNormal];
    }
    [downButton setBackgroundColor:[UIColor orangeColor]];
    [downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    downButton.titleLabel.font = YKTextNormalFont;
    [downButton addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:downButton];
    self.downButton = downButton;
  
    // 打开聊吧按钮
    UIButton *openChatBtn = [[UIButton alloc] init];
    openChatBtn.xf_y = CGRectGetMaxY(iconView.frame) + YKMargin;
    openChatBtn.xf_width = (SCREEN.width / 3) * 2;
    openChatBtn.xf_x = SCREEN.width / 6;
    openChatBtn.xf_height = YKMargin * 2;
    [openChatBtn setBackgroundImage:[UIImage imageNamed:@"button_enroll_n"] forState:UIControlStateNormal];
    [openChatBtn setBackgroundImage:[UIImage imageNamed:@"button_enroll_s"] forState:UIControlStateHighlighted];
    [openChatBtn setTitle:[NSString stringWithFormat:@"打开%@吧", model.name] forState:UIControlStateNormal];
    openChatBtn.titleLabel.font = YKTextNormalFont;
    [openChatBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    openChatBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [openChatBtn addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:openChatBtn];
    self.openChatBtn = openChatBtn;
    
    // cell高
    self.headerViewHeight = CGRectGetMaxY(openChatBtn.frame) + YKSmallSpace;
    
}


#pragma mark - 事件监听

- (void)downClick:(UIButton *)button {
    
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tbc.selectedViewController;
    
    XFWebViewController *webVC = [[XFWebViewController alloc] init];
    webVC.navTitle = @"App Store";
    webVC.url = self.model.downAct;
    [nav pushViewController:webVC animated:YES];
    
}

- (void)openBtnClick:(UIButton *)button {
    
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tbc.selectedViewController;
    
    XFWebViewController *webVC = [[XFWebViewController alloc] init];
    webVC.navTitle = @"百度贴吧";
    webVC.url = self.model.appbarUrl;
    [nav pushViewController:webVC animated:YES];
}




@end

















