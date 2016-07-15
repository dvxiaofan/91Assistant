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
    //summaryLabel.text = @"这里是应用插件机捡垃圾啊辣椒粉啦打飞机 ADSL 附近连接";
    summaryLabel.textColor = YKTextGrayColor;
    summaryLabel.font = YKMidleTextFont;
    summaryLabel.numberOfLines = 0;
    summaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //CGSize summaryLabelSize = [summaryLabel sizeThatFits:CGSizeMake(SCREEN.width - YKMargin * 2, MAXFLOAT)];
    summaryLabel.frame = CGRectMake(YKMargin, CGRectGetMaxY(sectionTitleLabel.frame), SCREEN.width - YKMargin * 2, YKMargin * 2);
    [self addSubview:summaryLabel];
    self.summaryLabel = summaryLabel;
    
    //self.cellHeight = CGRectGetMaxY(summaryLabel.frame) + YKMargin;
    self.cellHeight = CGRectGetMaxY(summaryLabel.frame) + YKMargin;
    
    
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    frame.origin.y += 1;
    
    [super setFrame:frame];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end















