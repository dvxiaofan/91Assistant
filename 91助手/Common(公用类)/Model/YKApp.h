//
//  YKApp.h
//  91助手
//
//  Created by xiaofans on 16/6/21.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKApp : NSObject

@property (nonatomic, copy)   NSString    *name;            // 名字
@property (nonatomic, copy)   NSString    *icon;            // 图标
@property (nonatomic, copy)   NSString    *resId;           //
@property (nonatomic, copy)   NSString    *downTimes;       // 下载次数
@property (nonatomic, copy)   NSString    *price;           // 价格
@property (nonatomic, copy)   NSString    *url;             // 链接
@property (nonatomic, assign) NSUInteger  size;             // 大小
@property (nonatomic, copy)   NSNumber    *star;            // 星级评价

@property (nonatomic, copy)   NSString    *detailUrl;       // 详情链接
@property (nonatomic, copy)   NSString    *downAct;         // 下载链接
@property (nonatomic, copy)   NSString    *cateName;        // 分类名
@property (nonatomic, copy)   NSString    *summary;         // 介绍
@property (nonatomic, copy)   NSString    *author;          // 作者
@property (nonatomic, assign) CGFloat     originalPrice;    // 价格
@property (nonatomic, assign) int         appType;          // 
@property (nonatomic, assign) int         state;            // 状态


/** 单行 cell 高度 */
@property (nonatomic, assign) CGFloat     singleCellHeight;
/** 多行 cell 高度 */
@property (nonatomic, assign) CGFloat     rowsCellHeight;
/** 专题 cell 高度 */
@property (nonatomic, assign) CGFloat     appCellHeight;




@end
