//
//  YKSectionHeaderView.m
//  91助手
//
//  Created by xiaofan on 16/6/6.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSectionHeaderView.h"



@interface YKSectionHeaderView ()

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIButton *moreBtn;

@end

@implementation YKSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.userInteractionEnabled = YES;
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    UIView *headerView = [[UIView alloc] init];
    //headerView.userInteractionEnabled = YES;
    [self addSubview:headerView];
    self.headerView = headerView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, SCREEN.width - 30, 20)];
    label.font = CELL_NAME_FONT;
    [headerView addSubview:label];
    self.label = label;
    
    // 更多 按钮
    UIButton *moreBtn = [[UIButton alloc] init];
    CGFloat moreBtnX = SCREEN.width - 60;
    CGFloat moreBtnY = 12;
    CGFloat moreBtnW = 25;
    CGFloat moreBtnH = 16;
    moreBtn.frame = CGRectMake(moreBtnX, moreBtnY, moreBtnW, moreBtnH);
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setBackgroundColor:[UIColor clearColor]];
    moreBtn.titleLabel.font = CELL_BTN_FONT;
    [moreBtn setTitleColor:CELL_BTN_COLOR forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    CGFloat imgViewX = CGRectGetMaxX(moreBtn.frame);
    CGFloat imgViewY = 15;
    CGFloat imgViewW = 12;
    CGFloat imgViewH = 10;
    imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    imgView.image = [UIImage imageNamed:@"web_next_nor"];
    imgView.clipsToBounds = YES;
    [headerView addSubview:imgView];
}
// 分区标题
- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
}

- (void)btnClick:(UIButton *)button {
    YKLog(@"更多");
    
    if ([self.delegate respondsToSelector:@selector(sectionHeaderView:)]) {
        [self.delegate sectionHeaderView:self];
        YKLog(@"实现代理");
    }
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
