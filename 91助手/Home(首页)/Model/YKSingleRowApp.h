//
//  YKSingleRowApp.h
//  91助手
//
//  Created by xiaofans on 16/6/21.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKSingleRowApp : NSObject

@property (nonatomic, copy)   NSString    *name;
@property (nonatomic, copy)   NSString    *icon;
@property (nonatomic, copy)   NSString    *resId;
@property (nonatomic, copy)   NSString    *downTimes;
@property (nonatomic, copy)   NSString    *price;
@property (nonatomic, assign) NSUInteger  size;
@property (nonatomic, assign) NSInteger     star;


//+ (instancetype)appWithDict:(NSDictionary *)dict;


@end
