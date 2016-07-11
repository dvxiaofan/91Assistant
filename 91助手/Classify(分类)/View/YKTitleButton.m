//
//  YKTitleButton.m
//  91助手
//
//  Created by xiaofans on 16/7/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKTitleButton.h"

@implementation YKTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 正常状态颜色
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        // 点击选中状态颜色
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return self;
}

/**
 *  防止长按按钮标题颜色变化重写此方法
 */
- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
