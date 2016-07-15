//
//  YKDetailSummaryCell.m
//  91助手
//
//  Created by xiaofans on 16/7/15.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKDetailSummaryCell.h"
#import "YKDetailModel.h"


@interface YKDetailSummaryCell ()

/** title */
@property (nonatomic, weak) UILabel *sectionTitleLabel;
/** summaryLavel */
@property (nonatomic, weak) UILabel *summaryLabel;
/** 展开 */
@property (nonatomic, weak) UIButton *openBtn;
/** 是否展开 */
@property (nonatomic, assign) BOOL flag;

@end

@implementation YKDetailSummaryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = YKBaseBgColor;
        self.userInteractionEnabled = YES;
    }
    return self;
}


- (void)createCellWithModel:(YKDetailModel *)model {
    
    // title
    UILabel *sectionTitleLabel = [[UILabel alloc] init];
    sectionTitleLabel.frame = CGRectMake(YKMargin, YKSmallSpace, SCREEN.width - YKMargin * 2, YKMargin);
    sectionTitleLabel.text = @"应用简介";
    sectionTitleLabel.textColor = YKTextBlackColor;
    sectionTitleLabel.font = YKTextBoldFont;
    [self addSubview:sectionTitleLabel];
    self.sectionTitleLabel = sectionTitleLabel;
    
    // summary
    UILabel *summaryLabel = [[UILabel alloc] init];
    summaryLabel.text = model.desc;
    summaryLabel.textColor = YKTextGrayColor;
    summaryLabel.font = YKMidleTextFont;
    summaryLabel.numberOfLines = 0;
    summaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize summaryLabelSize = [summaryLabel sizeThatFits:CGSizeMake(SCREEN.width - YKMargin * 2, MAXFLOAT)];
    summaryLabel.frame = CGRectMake(YKMargin, CGRectGetMaxY(sectionTitleLabel.frame), SCREEN.width - YKMargin * 2, summaryLabelSize.height);
    
    [self addSubview:summaryLabel];
    self.summaryLabel = summaryLabel;
    
    // 展开收起按钮
    UIButton *openButton = [[UIButton alloc] init];
    openButton.frame = CGRectMake(SCREEN.width - YKMargin * 4, (CGRectGetMaxY(summaryLabel.frame) + YKMargin), YKMargin * 3, 20);
    [openButton setTitle:@"收缩" forState:UIControlStateNormal];
    openButton.titleLabel.font = YKTextSmallFont;
    [openButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [openButton setBackgroundImage:[UIImage imageNamed:@"button_login_n"] forState:UIControlStateNormal];
    [openButton addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:openButton];
    self.openBtn = openButton;
    
    self.cellHeight = CGRectGetMaxY(openButton.frame) + YKSmallMargin;
    
    
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    frame.origin.y += 1;
    
    [super setFrame:frame];
}

#pragma mark - 事件监听

- (void)openBtnClick:(UIButton *)button {
    
    YKLogFunc
    
    //if (self.flag == NO) {
        //CGSize summaryLabelSize = [self.summaryLabel sizeThatFits:CGSizeMake(SCREEN.width - YKMargin * 2, MAXFLOAT)];
        
        //self.summaryLabel.frame = CGRectMake(YKMargin, CGRectGetMaxY(self.sectionTitleLabel.frame), SCREEN.width - YKMargin * 2, summaryLabelSize.height);
        
        //self.openBtn.xf_y = CGRectGetMaxY(self.summaryLabel.frame) + YKMargin;
        
        //self.cellHeight = CGRectGetMaxY(self.openBtn.frame) + YKSmallMargin;
        
        //self.flag = YES;
    //} else {
        //self.summaryLabel.frame = CGRectMake(YKMargin, CGRectGetMaxY(self.sectionTitleLabel.frame), SCREEN.width - YKMargin * 2, YKMargin * 2);
        
        //self.openBtn.xf_y = CGRectGetMaxY(self.summaryLabel.frame) + YKMargin;
        
        //self.cellHeight = CGRectGetMaxY(self.openBtn.frame) + YKSmallMargin;
        
        //self.flag = NO;
    //}
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    YKLogFunc
}

@end















