//
//  UIImageView+XFExtension.m
//
//  Created by xiaofan on 16/7/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

#import "UIImageView+XFExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (XFExtension)

- (void)xf_setRectHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return;
        
        self.layer.cornerRadius = 8.0;
        self.clipsToBounds = YES;
    }];
}

- (void)xf_setSixSideHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return;
        
        UIBezierPath * path = [UIBezierPath bezierPath];
        path.lineWidth = 2;
        [path moveToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (YKAppWH / 2), (YKAppWH / 4))];
        [path addLineToPoint:CGPointMake((YKAppWH / 2), 0)];
        [path addLineToPoint:CGPointMake(YKAppWH - ((sin(M_1_PI / 180 * 60)) * (YKAppWH / 2)), (YKAppWH / 4))];
        [path addLineToPoint:CGPointMake(YKAppWH - ((sin(M_1_PI / 180 * 60)) * (YKAppWH / 2)), (YKAppWH / 2) + (YKAppWH / 4))];
        [path addLineToPoint:CGPointMake((YKAppWH / 2), YKAppWH)];
        [path addLineToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (YKAppWH / 2), (YKAppWH / 2) + (YKAppWH / 4))];
        [path closePath];
        CAShapeLayer * shapLayer = [CAShapeLayer layer];
        shapLayer.lineWidth = 2;
        shapLayer.path = path.CGPath;
        self.layer.mask = shapLayer;
    }];
}

@end
