//
//  YKDetailSingelScrollCell.h
//  91助手
//
//  Created by xiaofans on 16/7/14.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YKDetailModel;

@interface YKDetailSingelScrollCell : UITableViewCell


/** singleCellHeight */
@property (nonatomic, assign) CGFloat cellHeight;



- (void)createViewWithModel:(YKDetailModel *)model;



@end
