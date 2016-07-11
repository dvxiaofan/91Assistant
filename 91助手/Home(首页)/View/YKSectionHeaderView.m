//
//  YKSectionHeaderView.m
//  91助手
//
//  Created by xiaofans on 16/7/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSectionHeaderView.h"

@interface YKSectionHeaderView ()

///** moreBtn */
//@property (nonatomic, weak) UIButton *moreBtn;
/** image */
@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation YKSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.font = YKSectionHeaderTestFont;
        
        [self createMoreBtn];
    }
    return self;
}

- (void)createMoreBtn {
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.backgroundColor = [UIColor orangeColor];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setBackgroundColor:[UIColor clearColor]];
    moreBtn.titleLabel.font = CELL_BTN_FONT;
    [moreBtn setTitleColor:CELL_BTN_COLOR forState:UIControlStateNormal];
    
    [self addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"web_next_nor"];
    imgView.clipsToBounds = YES;
    [self addSubview:imgView];
    self.imgView = imgView;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.xf_height = YKMargin * 2;
    
    self.textLabel.xf_x = YKMargin;
    self.textLabel.xf_y = YKSmallMargin;
    
    self.moreBtn.frame = CGRectMake(SCREEN.width - 55, 12, 25, 16);
    
    self.imgView.frame = CGRectMake(CGRectGetMaxX(self.moreBtn.frame), 15, 12, 10);
}

@end













