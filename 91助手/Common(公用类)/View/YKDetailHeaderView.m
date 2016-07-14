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


@interface YKDetailHeaderView ()<UIScrollViewDelegate>

/** view */
@property (nonatomic, strong) UIView *mView;
/** scrollView */
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


@end

@implementation YKDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        //self.backgroundColor = YKBaseBgColor;
        //[self createView];
    }
    return self;
}


- (void)createViewWithModel:(YKDetailModel *)model {
    
    
    //NSArray *image = model.snapshots;
    //YKLog(@"name = %@", image);
    
    UIView *mView = [[UIView alloc] init];
    mView.frame = self.bounds;
    mView.backgroundColor = YKBaseBgColor;
    [self addSubview:mView];
    self.mView = mView;
    
    // 滚动快照视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, self.xf_width, 250);
    [mView addSubview:scrollView];
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
    
    [mView addSubview:iconView];
    self.iconView = iconView;
    
    iconView.backgroundColor = YKRandomColor;
    
    // 名字
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.xf_x = CGRectGetMaxX(self.iconView.frame) + YKSmallMargin;
    nameLabel.xf_y = self.iconView.xf_y + YKSmallMargin;
    nameLabel.xf_width = SCREEN.width - self.iconView.xf_width - YKMargin * 2;
    nameLabel.xf_height = YKMargin;
    
    nameLabel.text = model.name;
    nameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    nameLabel.textColor = [UIColor whiteColor];
    
    [mView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 星级评价
    YKStarView *starView = [[YKStarView alloc] init];
    starView.xf_x = nameLabel.xf_x;
    starView.xf_y = CGRectGetMaxY(nameLabel.frame) + YKSmallMargin;
    starView.xf_width = 100;
    starView.xf_height = 15;
    
    starView.showStar = [model.star intValue] * 20;
    
    [mView addSubview:starView];
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
    
    [mView addSubview:fileSizeLabel];
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
    
    [mView addSubview:versionLabel];
    self.versionLabel = versionLabel;
    
    // 下载按钮
    UIButton *downButton = [[UIButton alloc] init];
    downButton.xf_x = SCREEN.width - YKMargin * 4;
    downButton.xf_y = CGRectGetMaxY(nameLabel.frame) + YKSmallMargin;
    downButton.xf_width = YKMargin * 3 + YKSmallMargin;
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
    downButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [downButton addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [mView addSubview:downButton];
    self.downButton = downButton;
  
    // 打开聊吧按钮
    UIButton *openChatBtn = [[UIButton alloc] init];
    openChatBtn.xf_y = CGRectGetMaxY(iconView.frame) + YKMargin;
    openChatBtn.xf_width = SCREEN.width / 2;
    openChatBtn.xf_x = SCREEN.width / 4;
    [openChatBtn setTitle:[NSString stringWithFormat:@"打开%@吧", model.name] forState:UIControlStateNormal];
    [openChatBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    openChatBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [mView addSubview:openChatBtn];
    self.openChatBtn = openChatBtn;
    
}

/*
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    // icon
    //NSString *url = @"http://bos.pgzs.com/itunesimg/61/512939461/ddd0cce65e046df546ef0f255e527cfd_512x512bb.114x114-75.jpg";
    //[self.iconView xf_setRectHeaderWithUrl:url placeholder:@"avatar_poto_defaul140"];
    
    //// 名字
    //self.nameLabel.text = @"国产全新玩法城市精灵在那里游戏名字";
    //self.nameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    //self.nameLabel.textColor = [UIColor whiteColor];
    
    //// 星级评价
    //self.starView.showStar = 4 * 20;
    
    //// 大小
    //self.fileSizeLabel.text = @"大小: 146.00MB";
    //self.fileSizeLabel.font = [UIFont systemFontOfSize:12.0];
    //self.fileSizeLabel.textColor = [UIColor grayColor];
    
    //// 版本
    //self.versionLabel.text = @"版本: 2.4.5";
    //self.versionLabel.font = [UIFont systemFontOfSize:12.0];
    //self.versionLabel.textColor = [UIColor grayColor];
    
    //// 下载按钮
    //[self.downButton setTitle:@"免费" forState:UIControlStateNormal];
    //self.downButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    //[self.downButton addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
    
//#warning 以上为册数数据
    
    
    // 滚动快照
    //self.scrollView.xf_x = 0;
    //self.scrollView.xf_y = 0;
    //self.scrollView.xf_width = SCREEN.width;
    //self.scrollView.xf_height = 250;
    //self.scrollView.contentSize = CGSizeMake(SCREEN.width * 3, self.scrollView.xf_height);
    //self.scrollView.showsVerticalScrollIndicator = NO;
    //self.scrollView.showsHorizontalScrollIndicator = NO;
    //self.scrollView.pagingEnabled = YES;
    
    //self.scrollView.delegate = self;
    
    
    ////self.scrollView.backgroundColor = YKRandomColor;
    
    //// icon
    //self.iconView.xf_x = YKMargin;
    //self.iconView.xf_y = CGRectGetMaxY(self.scrollView.frame) - 33;
    //self.iconView.xf_width = 67;
    //self.iconView.xf_height = 67;
    
    //self.iconView.backgroundColor = YKRandomColor;
    
    // 名字
    //self.nameLabel.xf_x = CGRectGetMaxX(self.iconView.frame) + YKSmallMargin;
    //self.nameLabel.xf_y = self.iconView.xf_y + YKSmallMargin;
    //self.nameLabel.xf_width = SCREEN.width - self.iconView.xf_width - YKMargin * 2;
    //self.nameLabel.xf_height = YKMargin;
    
    //self.nameLabel.backgroundColor = YKRandomColor;
    
    //// 星级评价
    //self.starView.xf_x = self.nameLabel.xf_x;
    //self.starView.xf_y = CGRectGetMaxY(self.nameLabel.frame) + YKSmallMargin;
    //self.starView.xf_width = 100;
    //self.starView.xf_height = 15;
    
    
    
    //// 大小
    //self.fileSizeLabel.xf_x = self.starView.xf_x;
    //self.fileSizeLabel.xf_y = CGRectGetMaxY(self.starView.frame);
    //CGSize fileSize = [self.fileSizeLabel.text xf_sizeWithFont:self.fileSizeLabel.font];
    //self.fileSizeLabel.xf_width = fileSize.width;
    //self.fileSizeLabel.xf_height = fileSize.height;
    
    //self.fileSizeLabel.backgroundColor = YKRandomColor;
    
    //// 版本
    //self.versionLabel.xf_x = CGRectGetMaxX(self.fileSizeLabel.frame) + 3;
    //self.versionLabel.xf_y = self.fileSizeLabel.xf_y;
    //CGSize versionSize = [self.versionLabel.text xf_sizeWithFont:self.versionLabel.font];
    //self.versionLabel.xf_width = versionSize.width;
    //self.versionLabel.xf_height = versionSize.height;
    
    //self.versionLabel.backgroundColor = YKRandomColor;
    
    //// 下载按钮
    //self.downButton.xf_x = SCREEN.width - YKMargin * 4;
    //self.downButton.xf_y = CGRectGetMaxY(self.nameLabel.frame) + YKSmallMargin;
    //self.downButton.xf_width = YKMargin * 3 + YKSmallMargin;
    //self.downButton.xf_height = 25;
    //self.downButton.layer.cornerRadius = 3.0;
    //self.downButton.clipsToBounds = YES;
    
    //self.downButton.backgroundColor = [UIColor orangeColor];
    
    // 打开聊吧按钮
    
   
    
    
}
 */
/*
- (void)setDetailModel:(YKDetailModel *)detailModel {
    //_detailModel = detailModel;
    
    YKLog(@"name = %@", detailModel.name);
    
    // icon
    [self.iconView xf_setRectHeaderWithUrl:detailModel.icon placeholder:@"avatar_poto_defaul140"];
    
    // 名字
    self.nameLabel.text = detailModel.name;
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    self.nameLabel.textColor = [UIColor whiteColor];
    
    // 星级评价
    self.starView.showStar = [detailModel.star intValue] * 20;
    
    // 大小
    CGFloat size = [detailModel.size doubleValue];
    NSString *sizeText = nil;
    if (size >= pow(10, 9)) {           // size >= 1GB
        sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
    } else if (size >= pow(10, 6)) {    // 1GB > size >= 1MB
        sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
    } else if (size >= pow(10, 3)) {    // 1MB > size >= 1KB
        sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
    } else {                            // 1KB > size
        sizeText = [NSString stringWithFormat:@"%zdB", size];
    }
    
    self.fileSizeLabel.text = [NSString stringWithFormat:@"大小: %@", sizeText];;
    self.fileSizeLabel.font = [UIFont systemFontOfSize:12.0];
    self.fileSizeLabel.textColor = [UIColor grayColor];
    
    // 版本
    self.versionLabel.text = [NSString stringWithFormat:@"版本: %@", detailModel.versionCode];
    self.versionLabel.font = [UIFont systemFontOfSize:12.0];
    self.versionLabel.textColor = [UIColor grayColor];
    
    // 下载按钮
    if ([detailModel.price isEqualToString:@"0.00"]) {
        [self.downButton setTitle:@"免费" forState:UIControlStateNormal];
        [self.downButton setBackgroundColor:[UIColor orangeColor]];
        [self.downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self.downButton setTitle:detailModel.price forState:UIControlStateNormal];
        [self.downButton setBackgroundColor:[UIColor whiteColor]];
        [self.downButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.downButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.downButton addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 打开聊吧按钮
    
}
*/
#pragma mark - 事件监听

- (void)downClick:(UIButton *)button {
    YKLogFunc
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    YKLogFunc
}


@end

















