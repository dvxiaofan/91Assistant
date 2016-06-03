//
//  YKTwoTableViewCell.h
//  91助手
//
//  Created by xiaofan on 16/6/3.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YKTwoTableViewCellDelegate;

@interface YKTwoTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat SingleRowCellHeight;

@property (nonatomic, assign) id <YKTwoTableViewCellDelegate> delegate;

@end

@protocol YKTwoTableViewCellDelegate <NSObject>

- (void)twoTableViewCell:(YKTwoTableViewCell *)cell;

@end