//
//  YKTenRowsTableViewCell.h
//  91助手
//
//  Created by xiaofan on 16/6/6.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol YKTenRowsTableViewCellDelegate;

@interface YKTenRowsTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, assign) id <YKTenRowsTableViewCellDelegate> delegate;

@end

@protocol YKTenRowsTableViewCellDelegate <NSObject>

- (void)tenRowsTableViewCell:(YKTenRowsTableViewCell *)cell;

@end
