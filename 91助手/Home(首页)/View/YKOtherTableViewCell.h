//
//  YKOtherTableViewCell.h
//  91助手
//
//  Created by xiaofan on 16/6/6.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKApp;

@protocol YKOtherTableViewCellDelegate <NSObject>

- (void)imgViewTapIndex:(NSInteger)index;

@end


@interface YKOtherTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, assign) id <YKOtherTableViewCellDelegate> delegate;
/** a */
@property (nonatomic, strong) YKApp *app;

/** iconArray */
@property (nonatomic, strong) NSArray <YKApp *>*iconArray;
@end
