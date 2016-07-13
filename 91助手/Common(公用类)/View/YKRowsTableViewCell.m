//
//  YKRowsTableViewCell.m
//  91助手
//
//  Created by xiaofan on 16/6/6.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKRowsTableViewCell.h"
#import "YKStarView.h"
#import "NSString+YKExtension.h"
#import "YKApp.h"

#define APP_NAME_FONT [UIFont systemFontOfSize:13.0]
#define APP_NAME_COLOR [UIColor blackColor]

#define CELL_INFO_FONT [UIFont systemFontOfSize:11.0]
#define CELL_INFO_COLOR [UIColor grayColor]

@interface YKRowsTableViewCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) YKStarView *starView;
@property (nonatomic, weak) UILabel *downNumLabel;
@property (nonatomic, weak) UILabel *fileSizeLabel;



@end

@implementation YKRowsTableViewCell



#pragma mark - 初始化
/**
 *  初始化
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createApp];
    }
    return self;
}

#pragma mark - UI布局

- (void)createApp {
    
    //图标
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    //名字
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //星级评级
    YKStarView *starView = [[YKStarView alloc] init];
    [self addSubview:starView];
    self.starView = starView;
    
    //下载次数
    UILabel *downNumLabel = [[UILabel alloc] init];
    [self addSubview:downNumLabel];
    self.downNumLabel = downNumLabel;
    
    //APP 大小
    UILabel *fileSizeLabel = [[UILabel alloc] init];
    [self addSubview:fileSizeLabel];
    self.fileSizeLabel = fileSizeLabel;
    
    //下载按钮
    UIButton *downBtn = [[UIButton alloc] init];
    [self addSubview:downBtn];
    self.downBtn = downBtn;
}

- (void)setApp:(YKApp *)app {
    _app = app;
    
    // appname
    self.nameLabel.text = app.name;
    self.nameLabel.font = APP_NAME_FONT;
    self.nameLabel.textColor = APP_NAME_COLOR;
    
    // 星级评价
    //if (app.star == nil) return;
    self.starView.showStar = [app.star intValue] * 20;
    
    //YKLog(@"nn = %@", app.star);
    
    
    // 图标
    [self.iconView xf_setRectHeaderWithUrl:app.icon placeholder:@"250_250_pic"];
    self.iconView.layer.cornerRadius = 8.0;
    self.iconView.clipsToBounds = YES;
    
    // 下载次数
    self.downNumLabel.text = [NSString stringWithFormat:@"%@下载", app.downTimes];
    self.downNumLabel.font = CELL_INFO_FONT;
    self.downNumLabel.textColor = CELL_INFO_COLOR;
    
    // 应用大小
    CGFloat fileSize = app.size / 1024.0 / 1024.0;
    self.fileSizeLabel.text = [NSString stringWithFormat:@"%.2fMB", fileSize];
    self.fileSizeLabel.textColor = CELL_INFO_COLOR;
    self.fileSizeLabel.font = CELL_INFO_FONT;
    
    // 下载按钮
    if ([app.price isEqualToString:@"0.00"]) {
        [self.downBtn setTitle:@"免费" forState:UIControlStateNormal];
        [self.downBtn setBackgroundColor:[UIColor orangeColor]];
        [self.downBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self.downBtn setTitle:app.price forState:UIControlStateNormal];
        [self.downBtn setBackgroundColor:[UIColor whiteColor]];
        [self.downBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.downBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.downBtn.layer.cornerRadius = 3.0;
    self.downBtn.clipsToBounds = YES;
    
}

//#pragma mark - 下载点击事件

//- (void)btnClick:(UIButton *)button {
    
    //if ([self.delegate respondsToSelector:@selector(rowsTableViewCell:)]) {
        //[self.delegate rowsTableViewCell:self];
    //}
//}

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 1;
    frame.origin.y += 1;
    
    [super setFrame:frame];
    
    // 图标
    self.iconView.frame = CGRectMake(YKMargin, YKSmallMargin, YKAppWH, YKAppWH);
    
    // 名字
    self.nameLabel.xf_x = CGRectGetMaxX(self.iconView.frame) + YKMargin;
    self.nameLabel.xf_y = self.iconView.xf_y;
    self.nameLabel.xf_width = SCREEN.width / 2;
    self.nameLabel.xf_height = YKMargin;
    
    // 星级评价
    self.starView.frame = CGRectMake(self.nameLabel.xf_x, (CGRectGetMaxY(self.nameLabel.frame) + 3), 100, YKMargin);
    
    // 下载次数
    CGSize labelSize = [self.downNumLabel.text sizeWithFont:self.downNumLabel.font];
    self.downNumLabel.frame = CGRectMake(self.nameLabel.xf_x, (CGRectGetMaxY(self.starView.frame) + 3), labelSize.width, labelSize.height);
    
    // 应用大小
    CGSize fileSize = [self.fileSizeLabel.text sizeWithFont:self.fileSizeLabel.font];
    self.fileSizeLabel.frame = CGRectMake((CGRectGetMaxX(self.downNumLabel.frame) + YKSmallMargin), self.downNumLabel.xf_y, fileSize.width, fileSize.height);
    
    // 下载按钮
    self.downBtn.frame = CGRectMake((CGRectGetMaxX(self.nameLabel.frame) + YKSmallMargin), YKMargin + YKSmallMargin, SCREEN.width / 5, 25);
    
}



@end












