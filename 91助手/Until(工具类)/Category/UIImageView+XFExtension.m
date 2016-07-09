//
//  UIImageView+XFExtension.m
//
//  Created by xiaofan on 16/7/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

#import "UIImageView+XFExtension.h"

@implementation UIImageView (XFExtension)

- (void)xf_setHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return;
        
        self.layer.cornerRadius = 8.0;
        self.clipsToBounds = YES;
    }];
}

@end
