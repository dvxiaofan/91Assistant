//
//  YKChatViewCell.h
//  91助手
//
//  Created by xiaofans on 16/6/29.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKChatViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *iconView;    // 图标
@property (nonatomic, strong) UILabel *nameLabel;       // 名字
@property (nonatomic, assign) CGFloat cellHeight;       // cell 高度

@end
