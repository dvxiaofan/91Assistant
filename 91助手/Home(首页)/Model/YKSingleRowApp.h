//
//  YKSingleRowApp.h
//  91助手
//
//  Created by xiaofans on 16/6/21.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKSingleRowApp : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *resId;


+ (instancetype)appWithDict:(NSDictionary *)dict;


@end
