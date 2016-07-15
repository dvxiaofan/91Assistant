//
//  YKDetailFooterView.m
//  91助手
//
//  Created by xiaofans on 16/7/15.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKDetailFooterView.h"
#import "YKDetailModel.h"


@interface YKDetailFooterView ()

/** view */
@property (nonatomic, weak) UIView *mView;

/** title */
@property (nonatomic, weak) UILabel *sectionTitleLabel;
/** 下载次数 */
@property (nonatomic, weak) UILabel *downTimesLabel;
/** 分类 */
@property (nonatomic, weak) UILabel *cateNameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *updateTimeLabel;
/** 语言 */
@property (nonatomic, weak) UILabel *lanLabel;
/** 作者 */
@property (nonatomic, weak) UILabel *authorLabel;
/** 兼容性 */
@property (nonatomic, weak) UILabel *requirementLabel;

@end

@implementation YKDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)createViewWithModel:(YKDetailModel *)model {
    
    // 主 view
    UIView *mView = [[UIView alloc] init];
    mView.frame = CGRectMake(0, 0, SCREEN.width, SCREEN.height);
    mView.backgroundColor = YKBaseBgColor;
    [self addSubview:mView];
    self.mView = mView;
    
    CGFloat infoTextWidth = SCREEN.width - YKMargin - YKSmallSpace;
    CGFloat inofTextHeight = YKMargin;
    
    // title
    UILabel *sectionTitleLabel = [[UILabel alloc] init];
    sectionTitleLabel.text = @"信息";
    sectionTitleLabel.font = YKTextBoldFont;
    sectionTitleLabel.textColor = YKTextBlackColor;
    sectionTitleLabel.frame = CGRectMake(YKMargin, YKSmallSpace, infoTextWidth, inofTextHeight);
    [mView addSubview:sectionTitleLabel];
    self.sectionTitleLabel = sectionTitleLabel;
    
    // 下载次数
    UILabel *downTimesLabel = [[UILabel alloc] init];
    downTimesLabel.text = [NSString stringWithFormat:@"下   载 : %@次下载", model.downTimes];
    downTimesLabel.font = YKMidleTextFont;
    downTimesLabel.textColor = YKTextGrayColor;
    downTimesLabel.frame = CGRectMake(YKMargin, CGRectGetMaxY(sectionTitleLabel.frame), infoTextWidth, inofTextHeight);
    [mView addSubview:downTimesLabel];
    self.downTimesLabel = downTimesLabel;
    
    // 分类
    UILabel *cateNameLabel = [[UILabel alloc] init];
    cateNameLabel.text = [NSString stringWithFormat:@"分   类 : %@", model.cateName];
    cateNameLabel.font = YKMidleTextFont;
    cateNameLabel.textColor = YKTextGrayColor;
    cateNameLabel.frame = CGRectMake(YKMargin, CGRectGetMaxY(downTimesLabel.frame), infoTextWidth, inofTextHeight);
    [mView addSubview:cateNameLabel];
    self.cateNameLabel = cateNameLabel;
    
    // 时间
    UILabel *updateTimeLabel = [[UILabel alloc] init];
    updateTimeLabel.text = [NSString stringWithFormat:@"时   间 : %@", model.updateTime];
    updateTimeLabel.textColor = YKTextGrayColor;
    updateTimeLabel.font = YKMidleTextFont;
    updateTimeLabel.frame = CGRectMake(YKMargin, CGRectGetMaxY(cateNameLabel.frame), infoTextWidth, inofTextHeight);
    [mView addSubview:updateTimeLabel];
    self.updateTimeLabel = updateTimeLabel;
    
    // 语言
    UILabel *lanLabel = [[UILabel alloc] init];
    lanLabel.text = [NSString stringWithFormat:@"语   言 : %@", model.lan];
    lanLabel.textColor = YKTextGrayColor;
    lanLabel.font = YKMidleTextFont;
    lanLabel.frame = CGRectMake(YKMargin, CGRectGetMaxY(updateTimeLabel.frame), infoTextWidth, inofTextHeight);
    [mView addSubview:lanLabel];
    self.lanLabel = lanLabel;
    
    // 作者
    UILabel *authorLabel = [[UILabel alloc] init];
    authorLabel.text = [NSString stringWithFormat:@"作   者 : %@", model.author];
    authorLabel.textColor = YKTextGrayColor;
    authorLabel.font = YKMidleTextFont;
    authorLabel.frame = CGRectMake(YKMargin, CGRectGetMaxY(lanLabel.frame), infoTextWidth, inofTextHeight);
    [mView addSubview:authorLabel];
    self.authorLabel = authorLabel;
    
    // 兼容性
    UILabel *requirementLabel = [[UILabel alloc] init];
    requirementLabel.text = [NSString stringWithFormat:@"兼容性 : %@", model.requirement];
    requirementLabel.numberOfLines = 0;
    requirementLabel.lineBreakMode = NSLineBreakByWordWrapping;
    requirementLabel.textColor = YKTextGrayColor;
    requirementLabel.font = YKMidleTextFont;
    CGSize reqLabelize = [requirementLabel sizeThatFits:CGSizeMake(infoTextWidth, MAXFLOAT)];
    requirementLabel.frame = CGRectMake(YKMargin, CGRectGetMaxY(authorLabel.frame), infoTextWidth, reqLabelize.height);
    [mView addSubview:requirementLabel];
    self.requirementLabel = requirementLabel;
    
    // footerViewHeight
    self.footerViewHeight = YKMargin * 6 + reqLabelize.height + YKSmallMargin;
    
}


@end


















