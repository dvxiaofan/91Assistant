//
//  YKSectionHeaderView.h
//  91助手
//
//  Created by xiaofans on 16/7/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKHomeModel;

@interface YKSectionHeaderView : UITableViewHeaderFooterView

/** moreBtn */
@property (nonatomic, weak) UIButton *moreBtn;

/** homeData */
@property (nonatomic, strong) YKHomeModel *homeData;

@end
