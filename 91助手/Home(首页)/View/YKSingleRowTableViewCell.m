//
//  YKSingleRowTableViewCell.m
//  91助手
//
//  Created by xiaofan on 16/6/3.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSingleRowTableViewCell.h"
#import "YKApp.h"



#define APP_NAME_FONT [UIFont systemFontOfSize:11.0]
#define APP_NAME_COLOR [UIColor blackColor]

#define ICON_TAG 100

@interface YKSingleRowTableViewCell ()

@property (nonatomic, weak) UIScrollView *showAppSV;  // 显示app的滚动视图
@property (nonatomic, weak) UIImageView *iconView;    // APP 图标
@property (nonatomic, weak) UILabel *appNameLabel;    // APP 名字


@end

@implementation YKSingleRowTableViewCell


/**
 *  初始化
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}



- (void)setApp:(YKApp *)app {
    _app = app;
    
    // 滚动视图
    UIScrollView *showAppSV = [[UIScrollView alloc] init];
    showAppSV.frame = CGRectMake(YKMargin, 5, SCREEN.width - YKMargin * 2, 90);
    [self addSubview:showAppSV];
    self.showAppSV = showAppSV;
    
    
    
    NSInteger count = 15;
    for (int i = 0; i < count; i ++) {
        //_singleRowApp = singleRowApps[i];
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.iconView xf_setRectHeaderWithUrl:app.icon placeholder:@"icon-29"];
        CGFloat imgViewX = i * YKAppWH + YKMargin * i;
        CGFloat imgViewY = YKSmallMargin;
        iconView.frame = CGRectMake(imgViewX, imgViewY, YKAppWH, YKAppWH);
        iconView.clipsToBounds = YES;
        iconView.layer.cornerRadius = 8.0;
        [showAppSV addSubview:iconView];
        self.iconView = iconView;
        iconView.tag = ICON_TAG + i;
        iconView.userInteractionEnabled = YES;
        
        // 增加点击手势识别
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIcon:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [iconView addGestureRecognizer:tap];
        
        // app名字
        UILabel *appNameLebal = [[UILabel alloc] init];
        CGFloat appNameY = CGRectGetMaxY(iconView.frame) + 8;
        appNameLebal.frame = CGRectMake(imgViewX, appNameY, YKAppWH, 10);
        appNameLebal.text = app.name;
        appNameLebal.font = APP_NAME_FONT;
        appNameLebal.textColor = APP_NAME_COLOR;
        appNameLebal.textAlignment = NSTextAlignmentCenter;
        [showAppSV addSubview:appNameLebal];
        self.appNameLabel = appNameLebal;
        
    }
    showAppSV.contentSize = CGSizeMake(self.iconView.frame.size.width * count + YKMargin * (count - 1), 0);
    showAppSV.showsHorizontalScrollIndicator = NO;
    
}


#pragma mark - APP 点击事件
- (void)tapIcon:(UITapGestureRecognizer *)sender {
    //YKLog(@"APP 被点击");
    UIImageView *iconView = (UIImageView *)sender.view;
    if ([self.delegate respondsToSelector:@selector(showAppScrollViewImageTapIndex:)]) {
        [self.delegate showAppScrollViewImageTapIndex:iconView.tag - ICON_TAG];
    }
}




@end














