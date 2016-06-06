//
//  YKTenRowsTableViewCell.m
//  91助手
//
//  Created by xiaofan on 16/6/6.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKTenRowsTableViewCell.h"
#import "YKStarView.h"
#import "NSString+YKExtension.h"

#define APP_NAME_FONT [UIFont systemFontOfSize:13.0]
#define APP_NAME_COLOR [UIColor blackColor]

#define CELL_INFO_FONT [UIFont systemFontOfSize:11.0]
#define CELL_INFO_COLOR [UIColor grayColor]

@interface YKTenRowsTableViewCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) YKStarView *starView;
@property (nonatomic, weak) UILabel *downNumLabel;
@property (nonatomic, weak) UILabel *fileSizeLabel;
@property (nonatomic, weak) UIButton *downBtn;



@property (nonatomic, assign) CGFloat far;              // 固定间隔

@end

@implementation YKTenRowsTableViewCell

#pragma mark - 初始化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutUI];
    }
    return self;
}

#pragma mark - UI布局

- (void)layoutUI {
    CGFloat far = 15;
    self.far = far;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    CGFloat iconViewX = far;
    CGFloat iconViewY = far / 2;
    iconView.frame = CGRectMake(iconViewX, iconViewY, ICONVIEW_WH, ICONVIEW_WH);
    iconView.image = [UIImage imageNamed:@"250_250_pic"];
    iconView.layer.cornerRadius = 8.0;
    iconView.clipsToBounds = YES;
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + far;
    CGFloat nameY = iconViewY + 3;
    CGFloat nameW = SCREEN.width - ICONVIEW_WH * 3;
    CGFloat nameH = 18;
    nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    nameLabel.text = @"腾讯新闻-头条新闻热度关注了吗";
    nameLabel.font = APP_NAME_FONT;
    nameLabel.textColor = APP_NAME_COLOR;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    YKStarView *starView = [[YKStarView alloc] init];
    CGFloat starY = CGRectGetMaxY(self.nameLabel.frame) + 3;
    CGFloat starW = 100;
    CGFloat starH = 20;
    starView.frame = CGRectMake(nameX, starY, starW, starH);
    starView.showStar = 3.5 * 20;
    [self addSubview:starView];
    self.starView = starView;
    
    UILabel *downNumLabel = [[UILabel alloc] init];
    downNumLabel.text = @">500万次下载";
    downNumLabel.font = CELL_INFO_FONT;
    downNumLabel.textColor = CELL_INFO_COLOR;
    CGFloat downNumY = CGRectGetMaxY(self.starView.frame) + 3;
    CGSize downNumSize = [downNumLabel.text sizeWithFont:downNumLabel.font];
    
    downNumLabel.frame = CGRectMake(nameX, downNumY, downNumSize.width, downNumSize.height);
    [self addSubview:downNumLabel];
    self.downNumLabel = downNumLabel;
    
    UILabel *fileSizeLabel = [[UILabel alloc] init];
    fileSizeLabel.text = @"688.09MB";
    fileSizeLabel.textColor = CELL_INFO_COLOR;
    fileSizeLabel.font = CELL_INFO_FONT;
    
    CGFloat fileX = CGRectGetMaxX(self.downNumLabel.frame) + 10;
    CGSize fileSize = [fileSizeLabel.text sizeWithFont:fileSizeLabel.font];
    fileSizeLabel.frame = CGRectMake(fileX, downNumY, fileSize.width, fileSize.height);
    [self addSubview:fileSizeLabel];
    self.fileSizeLabel = fileSizeLabel;
    
    UIButton *downBtn = [[UIButton alloc] init];
    CGFloat btnX = CGRectGetMaxX(self.nameLabel.frame) + far + 5;
    CGFloat btnY = far * 2;
    CGFloat btnW = 55;
    CGFloat btnH = 25;
    downBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [downBtn setTitle:@"免费" forState:UIControlStateNormal];
    [downBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downBtn setBackgroundColor:[UIColor orangeColor]];
    [downBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    downBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    downBtn.layer.cornerRadius = 3.0;
    downBtn.clipsToBounds = YES;
    [self addSubview:downBtn];
    self.downBtn = downBtn;
    
    self.rowHeight = CGRectGetMaxY(self.downNumLabel.frame) + far / 2;
    
}

#pragma mark - 下载点击事件

- (void)btnClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(tenRowsTableViewCell:)]) {
        [self.delegate tenRowsTableViewCell:self];
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
