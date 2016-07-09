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
    UIImageView *iconView = [[UIImageView alloc] init];
    
    iconView.frame = CGRectMake(far, far / 2, 48, 48);
    
    [self addSubview:iconView];
    self.iconView = iconView;
    
    self.cellHeight = CGRectGetMaxY(iconView.frame) + far / 2;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    
    nameLabel.frame = CGRectMake((CGRectGetMaxX(iconView.frame) + far), far, SCREEN.width - nameLabel.xf_x, iconView.xf_height / 2);
    
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
}




@end










