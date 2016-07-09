//
//  YKListTags.h
//  91助手
//
//  Created by xiaofans on 16/7/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKListTags : NSObject

/** tagNmae */
@property (nonatomic, copy) NSString *tagName;
/** url */
@property (nonatomic, copy) NSString *url;
/** selected */
@property (nonatomic, assign) BOOL selected;

@end
