//
//  YKSingleRowTableViewCell.m
//  91助手
//
//  Created by xiaofan on 16/6/3.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSingleRowTableViewCell.h"



#define CELL_NAME_FONT
#define CELL_BTN_FONT
#define SINGLE_NAME_FONT


@interface YKSingleRowTableViewCell ()

@property (nonatomic, strong) UILabel *cellNameLabel;   // cell 名字
@property (nonatomic, strong) UIButton *moreBtn;        // 更多 按钮
@property (nonatomic, strong) UIScrollView *showAppSV;  // 显示app的滚动视图
@property (nonatomic, strong) UIImageView *iconView;    // APP 图标
@property (nonatomic, strong) UILabel *appNameLabel;    // APP 名字

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
    CGFloat far = 30;
    self.far = far;
    
    // cell名字
    UILabel *cellNameLabel = [[UILabel alloc] init];
    CGFloat cellNameX = far / 2;
    CGFloat cellNameY = far / 2;
    CGFloat cellNameW = 60;
    CGFloat cellNameH = 22;
    cellNameLabel.frame = CGRectMake(cellNameX, cellNameY, cellNameW, cellNameH);
    cellNameLabel.text = @"热门应用";
    cellNameLabel.font = [UIFont boldSystemFontOfSize:12.0];
    cellNameLabel.textColor = [UIColor blackColor];
    [self addSubview:cellNameLabel];
    self.cellNameLabel = cellNameLabel;
    
    // 更多 按钮
    // 滚动视图
    // 图标
    // APP名字
    //
    //
}














- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
