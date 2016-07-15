//
//  YKDetailModel.h
//  91助手
//
//  Created by xiaofans on 16/7/13.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKDetailModel : NSObject

/** name */
@property (nonatomic, copy) NSString *name;
/** icon */
@property (nonatomic, copy) NSString *icon;
/** 版本号 */
@property (nonatomic, copy) NSString *versionCode;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 介绍 */
@property (nonatomic, copy) NSString *desc;

/** 快照 */
@property (nonatomic, strong) NSArray *snapshots;

/** 下载此应用的人也下载了 */
@property (nonatomic, strong) NSArray *recommendSofts;


/** 应用大小 */
@property (nonatomic, copy) NSNumber *size;
/** 星级评价 */
@property (nonatomic, copy) NSNumber *star;

/**  下载次数 */
@property (nonatomic, copy) NSString *downTimes;
/** 分类 */
@property (nonatomic, copy) NSString *cateName;
/** 时间 */
@property (nonatomic, copy) NSString *updateTime;
/** 语言 */
@property (nonatomic, copy) NSString *lan;
/** 作者 */
@property (nonatomic, copy) NSString *author;
/** 兼容性 */
@property (nonatomic, copy) NSString *requirement;









@end














