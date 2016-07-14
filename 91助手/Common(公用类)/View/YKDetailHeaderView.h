//
//  YKDetailHeaderView.h
//  91助手
//
//  Created by xiaofans on 16/7/13.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YKDetailModel;

@interface YKDetailHeaderView : UIView

/** detail */
//@property (nonatomic, strong) YKDetailModel *detailModel;

/** hh */
@property (nonatomic, assign) CGFloat headerViewHeight;

- (void)createViewWithModel:(YKDetailModel *)model;

@end
