//
//  YKChatCellModel.h
//  91助手
//
//  Created by xiaofans on 16/6/29.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKChatCellModel : NSObject

@property (nonatomic, copy) NSString *name; // 分类名
@property (nonatomic, copy) NSString *icon; // 图标
@property (nonatomic, copy) NSString *act;  // url


@property (nonatomic, assign) CGFloat chatCellHeight;       // cell 高度

@end
