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
    
    iconView.x = far;
    iconView.y = far / 2;
    iconView.width = 48;
    iconView.height = 48;
    
    //iconView.backgroundColor = YKRandomColor;
    [self addSubview:iconView];
    self.iconView = iconView;
    
    self.cellHeight = CGRectGetMaxY(iconView.frame) + far / 2;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.x = CGRectGetMaxX(iconView.frame) + far;
    nameLabel.centerY = far;
    nameLabel.width = SCREEN.width - nameLabel.x;
    nameLabel.height = iconView.height / 2;
    
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



