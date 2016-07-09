//
//  YKClassifyCell.m
//  91助手
//
//  Created by xiaofans on 16/7/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKClassifyCell.h"
#import "YKClassify.h"
#import "YKListTags.h"

@interface YKClassifyCell ()

/** iconView */
@property (nonatomic, weak) UIImageView *iconView;
/** nameLabel */
@property (nonatomic, weak) UILabel *nameLabel;
/** infoLabel */
@property (nonatomic, weak) UILabel *summaryLabel;

@end

@implementation YKClassifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
    }
    return self;
}


- (void)setupCell {
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // 名字
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // info
    UILabel *summaryLabel = [[UILabel alloc] init];
    [self addSubview:summaryLabel];
    self.summaryLabel = summaryLabel;
}

- (void)setApp:(YKClassify *)app {
    _app = app;
    
    // 头像
    [self.iconView xf_setHeaderWithUrl:app.icon placeholder:@"avatar_poto_defaul140"];
    
    // 名字
    self.nameLabel.text = app.name;
    
    // info
    self.summaryLabel.text = app.summary;
    self.summaryLabel.font = [UIFont systemFontOfSize:12.0];
    self.summaryLabel.textColor = [UIColor grayColor];
    
}

- (void)setFrame:(CGRect)frame {
    
    
    frame.size.height -= 1;
    frame.origin.y += 1;
    
    [super setFrame:frame];
    
    // 头像
    self.iconView.frame = CGRectMake(YKMargin, YKSmallMargin, YKButtonWH, YKButtonWH);
    
    // 名字
    self.nameLabel.frame = CGRectMake((CGRectGetMaxX(self.iconView.frame) + YKSmallMargin), YKSmallMargin + 5, 200, YKMargin);
    
    // info
    self.summaryLabel.frame = CGRectMake((CGRectGetMaxX(self.iconView.frame) + YKSmallMargin), (CGRectGetMaxY(self.nameLabel.frame) + YKMargin), SCREEN.width - self.iconView.xf_width, YKMargin);
    
    
    
}

@end













