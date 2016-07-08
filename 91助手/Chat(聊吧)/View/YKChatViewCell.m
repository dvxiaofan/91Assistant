//
//  YKChatViewCell.m
//  91助手
//
//  Created by xiaofans on 16/6/29.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKChatViewCell.h"
#import "YKChatCellModel.h"


@interface YKChatViewCell ()

//@property (nonatomic, strong) UIImageView *iconView;    // 图标
//@property (nonatomic, strong) UILabel *nameLabel;       // 名字



@end

@implementation YKChatViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //self.backgroundColor = YKRandomColor;
        
        [self setupCell];
        
    }
    return self;
}

- (void)setupCell{
    CGFloat far = 20;
    YKLogFunc
    UIImageView *iconView = [[UIImageView alloc] init];
    
    iconView.xf_x = far;
    iconView.xf_y = far / 2;
    iconView.xf_width = 48;
    iconView.xf_height = 48;
    
    //iconView.backgroundColor = YKRandomColor;
    [self addSubview:iconView];
    self.iconView = iconView;
    
    self.cellHeight = CGRectGetMaxY(iconView.frame) + far / 2;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.xf_x = CGRectGetMaxX(iconView.frame) + far;
    nameLabel.xf_centerY = far;
    nameLabel.xf_width = SCREEN.width - nameLabel.xf_x;
    nameLabel.xf_height = iconView.xf_height / 2;
    
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



