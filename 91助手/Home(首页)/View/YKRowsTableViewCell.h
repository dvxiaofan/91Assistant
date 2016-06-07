//
//  YKRowsTableViewCell.h
//  91助手
//
//  Created by xiaofan on 16/6/7.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YKRowsTableViewCellDelegate;

@interface YKRowsTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, assign) id <YKRowsTableViewCellDelegate> delegate;

@end

@protocol YKRowsTableViewCellDelegate <NSObject>

- (void)rowsTableViewCell:(YKRowsTableViewCell *)cell;

@end
