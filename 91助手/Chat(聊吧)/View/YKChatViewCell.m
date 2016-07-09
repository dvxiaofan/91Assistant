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

@property (nonatomic, weak) UIImageView *iconView;    // 图标
@property (nonatomic, weak) UILabel *nameLabel;       // 名字



@end

@implementation YKChatViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
}

- (void)setModel:(YKChatCellModel *)model {
    _model = model;
    
    [self.iconView xf_setHeaderWithUrl:model.icon placeholder:@"avatar_ba_defaul140"];
    
    self.nameLabel.text = model.name;
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 1;
    frame.origin.y += 1;
    
    [super setFrame:frame];
    
    self.iconView.frame = CGRectMake(YKMargin, YKSmallMargin, YKAppWH, YKAppWH);
    
    self.nameLabel.xf_x = CGRectGetMaxX(self.iconView.frame) + YKMargin;
    self.nameLabel.xf_y = YKMargin + YKSmallMargin;
    self.nameLabel.xf_width = 200;
    self.nameLabel.xf_height = YKMargin;
    
    
    //self.nameLabel.frame = CGRectMake(self.nameLabel.xf_x, YKMargin, SCREEN.width - self.nameLabel.xf_x, self.iconView.xf_height / 2);
    
}



@end










