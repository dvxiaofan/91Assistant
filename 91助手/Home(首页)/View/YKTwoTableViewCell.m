//
//  YKTwoTableViewCell.m
//  91助手
//
//  Created by xiaofan on 16/6/3.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKTwoTableViewCell.h"





@interface YKTwoTableViewCell ()

@property (nonatomic, strong) UILabel *cellNameLabel;   // cell 名字
@property (nonatomic, assign) CGFloat far;              // 固定间隔

@end

@implementation YKTwoTableViewCell


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
    cellNameLabel.text = @"编辑推荐";
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
