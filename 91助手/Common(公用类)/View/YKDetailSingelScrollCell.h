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

- (void)createViewWithModel:(YKDetailModel *)model;

/** model */
@property (nonatomic, strong) YKDetailModel *model;

@end
