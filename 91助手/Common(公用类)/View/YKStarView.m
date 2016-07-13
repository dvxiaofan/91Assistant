//
//  YKStarView.m
//  test
//
//  Created by 张张张小烦 on 16/5/14.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKStarView.h"
#import "NSString+YKExtension.h"


@implementation YKStarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        //未点亮时的颜色是 灰色的
        self.emptyColor = [UIColor grayColor];
        //点亮时的颜色是 亮黄色的
        self.fullColor = [UIColor orangeColor];
        //默认的长度设置为100
        self.maxStar = 100;
    }
    
    return self;
}

//重绘视图
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSString* stars = @"★★★★★";

    rect = self.bounds;
    CGSize starSize = [stars xf_sizeWithFont:[UIFont systemFontOfSize:15]];
    rect.size = starSize;
    [_emptyColor set];
    [stars drawInRect:rect withFont:[UIFont systemFontOfSize:15]];
    //[stars drawInRect:rect withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.0], NSFontAttributeName, nil]];
    
    CGRect clip = rect;
    clip.size.width = clip.size.width * _showStar / _maxStar;
    CGContextClipToRect(context,clip);
    [_fullColor set];
    [stars drawInRect:rect withFont:[UIFont systemFontOfSize:15]];
    //[stars drawInRect:rect withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.0], NSFontAttributeName, nil]];

}



@end
