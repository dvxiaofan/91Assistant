//
//  YKDetailSummaryCell.h
//  91助手
//
//  Created by xiaofans on 16/7/15.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YKDetailModel;

@interface YKDetailSummaryCell : UITableViewCell

/** cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;


- (void)createCellWithModel:(YKDetailModel *)model;

@end


