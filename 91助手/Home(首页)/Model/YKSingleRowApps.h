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

/*
 "resId":1125307633,
 "detailUrl":"http://applebbx.sj.91.com/api/?act=226&resId=1125307633&pact=708&placeId=1000262&mt=1&pid=2&spid=2",
 "star":0,
 "downAct":"http://applebbx.sj.91.com/softs.ashx?act=207&resId=1125307633&placeId=1000261&url=https%3a%2f%2fitunes.apple.com%2fcn%2fapp%2fping-guo-zhu-shou-shou-ji%2fid1125307633%3fmt%3d8%26uo%3d4&mt=1&pid=2&spid=2&pos=0",
 "appType":1,
 "icon":"http://bos.pgzs.com/itunesimg/33/1125307633/178c4cc099a126a6ffb24fab552ed435_512x512bb.114x114-75.jpg",
 "name":"苹果助手 - 手机端专业版",
 "cateName":"效率",
 "originalPrice":"0.00",
 "price":"0.00",
 "state":1,
 "downTimes":"<1 万",
 "summary":"基本特点：测试网络速度; 监控您的移动流量; 监控您的 iPhone 内存状态",
 "author":"a peng cui",
 "size":6659712
*/