//
//  YKSingleRowTableViewCell.m
//  91助手
//
//  Created by xiaofan on 16/6/3.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSingleRowTableViewCell.h"




#define APP_NAME_FONT [UIFont systemFontOfSize:12.0]
#define APP_NAME_COLOR [UIColor blackColor]

#define ICON_TAG 100

@interface YKSingleRowTableViewCell ()

@property (nonatomic, weak) UIScrollView *showAppSV;  // 显示app的滚动视图
@property (nonatomic, weak) UIImageView *iconView;    // APP 图标
@property (nonatomic, weak) UILabel *appNameLabel;    // APP 名字

@property (nonatomic, assign) CGFloat far;              // 固定间隔

@end

@implementation YKSingleRowTableViewCell

/**
 *  初始化
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutUI];
    }
    return self;
}

#pragma mark - UI布局

- (void)layoutUI {
    CGFloat far = 15;
    self.far = far;
    
    // 滚动视图
    UIScrollView *showAppSV = [[UIScrollView alloc] init];
    CGFloat svX = far;
    CGFloat svY = 5;
    CGFloat svW = SCREEN.width - svX * 2;
    CGFloat svH = 90;
    showAppSV.frame = CGRectMake(svX, svY, svW, svH);
    [self addSubview:showAppSV];
    self.showAppSV = showAppSV;
    
    NSInteger count = 15;
    
    for (int i = 0; i < count; i ++) {
        UIImageView *iconView = [[UIImageView alloc] init];
        //CGFloat imgViewWH = 60;
        CGFloat imgViewX = i * ICONVIEW_WH + far * i;
        CGFloat imgViewY = far / 2;
        iconView.frame = CGRectMake(imgViewX, imgViewY, ICONVIEW_WH, ICONVIEW_WH);
        iconView.image = [UIImage imageNamed:@"icon-29"];
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
        appNameLebal.frame = CGRectMake(imgViewX, appNameY, ICONVIEW_WH, 10);
        
        appNameLebal.text = @"正确打领带";
        appNameLebal.font = APP_NAME_FONT;
        appNameLebal.textColor = APP_NAME_COLOR;
        [showAppSV addSubview:appNameLebal];
        self.appNameLabel = appNameLebal;
        
    }
    showAppSV.contentSize = CGSizeMake(self.iconView.frame.size.width * count + far * (count - 1), 0);
    showAppSV.showsHorizontalScrollIndicator = NO;
    
    self.rowHeight = CGRectGetMaxY(self.appNameLabel.frame) + far;
}

#pragma mark - APP 点击事件
- (void)tapIcon:(UITapGestureRecognizer *)sender {
    //YKLog(@"APP 被点击了");
    UIImageView *iconView = (UIImageView *)sender.view;
    if ([self.delegate respondsToSelector:@selector(showAppScrollViewImageTapIndex:)]) {
        [self.delegate showAppScrollViewImageTapIndex:iconView.tag - ICON_TAG];
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
