//
//  YKApp.h
//  91助手
//
//  Created by xiaofans on 16/6/21.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKApp : NSObject

@property (nonatomic, copy)   NSString    *name;
@property (nonatomic, copy)   NSString    *icon;
@property (nonatomic, copy)   NSString    *resId;
@property (nonatomic, copy)   NSString    *downTimes;
@property (nonatomic, copy)   NSString    *price;
@property (nonatomic, copy)   NSString    *url;
@property (nonatomic, assign) NSUInteger  size;
@property (nonatomic, assign) NSInteger   star;


@property (nonatomic, copy)   NSString    *detailUrl;
@property (nonatomic, copy)   NSString    *downAct;
@property (nonatomic, copy)   NSString    *cateName;
@property (nonatomic, copy)   NSString    *summary;         // 介绍
@property (nonatomic, copy)   NSString    *author;
@property (nonatomic, assign) CGFloat     originalPrice;
@property (nonatomic, assign) int         appType;
@property (nonatomic, assign) int         state;


/** 当行 cell 高度 */
@property (nonatomic, assign) CGFloat     singleCellHeight;
/** 多行 cell 高度 */
@property (nonatomic, assign) CGFloat     rowsCellHeight;
/** 专题 cell 高度 */
@property (nonatomic, assign) CGFloat     appCellHeight;




@end
