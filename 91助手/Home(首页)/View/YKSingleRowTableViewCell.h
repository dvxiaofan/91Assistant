//
//  YKSingleRowTableViewCell.h
//  91助手
//
//  Created by xiaofan on 16/6/3.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YKSingleRowTableViewCellDelegate <NSObject>

- (void)showAppScrollViewImageTapIndex:(NSInteger)index;

@end

@interface YKSingleRowTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, assign) id <YKSingleRowTableViewCellDelegate> delegate;

@end

