//
//  NSString+YKExtension.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "NSString+YKExtension.h"

@implementation NSString (YKExtension)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
