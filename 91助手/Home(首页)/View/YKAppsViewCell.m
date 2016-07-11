//
//  YKAppsViewCell.m
//  91助手
//
//  Created by xiaofans on 16/7/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKAppsViewCell.h"
#import "YKApp.h"

@interface YKAppsViewCell ()

/** iconView */
@property (nonatomic, weak) UIImageView *iconView;
/** name */
@property (nonatomic, weak) UILabel *nameLabel;
/** 介绍 */
@property (nonatomic, weak) UILabel *summaryLabel;

/** far */
@property (nonatomic, assign) CGRect far;

@end

@implementation YKAppsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = YKBaseBgColor;
        [self setupView];
    }
    return self;
}

- (void)setupView {
    // 图片
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // name
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 介绍
    UILabel *summaryLabel = [[UILabel alloc] init];
    [self addSubview:summaryLabel];
    self.summaryLabel = summaryLabel;
}

- (void)setApp:(YKApp *)app {
    _app = app;
    
    // 图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:app.icon] placeholderImage:[UIImage imageNamed:@"bg_name"]];
    
    // name
    self.nameLabel.text = app.name;
    self.nameLabel.font = YKSectionHeaderTestFont;
    
    // 介绍
    self.summaryLabel.text = app.summary;
    self.summaryLabel.font = [UIFont systemFontOfSize:12.0];
    self.summaryLabel.textColor = [UIColor grayColor];
}

- (void)setFrame:(CGRect)frame {
    frame.size.width -= YKSmallSpace * 2;
    frame.size.height -= YKSmallSpace;
    frame.origin.y += YKSmallSpace;
    frame.origin.x += YKSmallSpace;
    
    [super setFrame:frame];
    
    CGFloat iconViewW = SCREEN.width - YKSmallSpace * 2;
    
    self.iconView.frame = CGRectMake(0, 0, iconViewW, SCREEN.width * 7 / 16);
    
    self.nameLabel.frame = CGRectMake(0, (CGRectGetMaxY(self.iconView.frame) + YKSmallSpace), iconViewW, YKMargin);
    
    self.summaryLabel.frame = CGRectMake(0, (CGRectGetMaxY(self.nameLabel.frame)), iconViewW, YKMargin);
    
}





@end














