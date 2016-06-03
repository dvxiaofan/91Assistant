//
//  YKSingleRowTableViewCell.h
//  91助手
//
//  Created by xiaofan on 16/6/3.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YKSingleRowTableViewCellDelegate;

@interface YKSingleRowTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat SingleRowCellHeight;

@property (nonatomic, assign) id <YKSingleRowTableViewCellDelegate> delegate;

@end

@protocol YKSingleRowTableViewCellDelegate <NSObject>

- (void)singleRowTableViewCell:(YKSingleRowTableViewCell *)cell;

@end