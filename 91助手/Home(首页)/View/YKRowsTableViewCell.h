//
//  YKRowsTableViewCell.h
//  91助手
//
//  Created by xiaofan on 16/6/7.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKApp;

@protocol YKRowsTableViewCellDelegate;

@interface YKRowsTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, assign) id <YKRowsTableViewCellDelegate> delegate;


/** ss */
@property (nonatomic, strong) YKApp *app;




@end

@protocol YKRowsTableViewCellDelegate <NSObject>

- (void)rowsTableViewCell:(YKRowsTableViewCell *)cell;

@end
