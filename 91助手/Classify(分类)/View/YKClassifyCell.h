//
//  YKClassifyCell.h
//  91助手
//
//  Created by xiaofans on 16/7/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKClassify, YKListTags;

@interface YKClassifyCell : UITableViewCell

/** app */
@property (nonatomic, strong) YKClassify *app;

/** li */
@property (nonatomic, strong) YKListTags *listTags;



@end
