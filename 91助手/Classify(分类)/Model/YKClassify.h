//
//  YKClassify.h
//  91助手
//
//  Created by xiaofans on 16/7/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YKListTags;

@interface YKClassify : NSObject

/** icon */
@property (nonatomic, copy) NSString *icon;
/** name */
@property (nonatomic, copy) NSString *name;
/** info */
@property (nonatomic, copy) NSString *summary;

/** listTags */
@property (nonatomic, strong) NSArray *listTags;


/** cell 高度 */
@property (nonatomic, assign) CGFloat   cellHeight;

@end
