//
//  YKSingleRowApps.h
//  91助手
//
//  Created by xiaofans on 16/6/21.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKSingleRowApps : NSObject

@property (nonatomic, copy) NSString *detailUrl;        //
@property (nonatomic, copy) NSString *downAct;          //
@property (nonatomic, copy) NSString *cateName;         //
@property (nonatomic, copy) NSString *summary;          //
@property (nonatomic, copy) NSString *author;           //
@property (nonatomic, copy) NSString *downTimes;        //
@property (nonatomic, assign) CGFloat star;             //
@property (nonatomic, assign) CGFloat originalPrice;    //
@property (nonatomic, assign) CGFloat price;            //
@property (nonatomic, assign) CGFloat size;             //
@property (nonatomic, assign) int appType;              //
@property (nonatomic, assign) int state;                //

@end

