//
//  XFUtility.m
//
//
//  Created by xiaofan on 16/5/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "XFUtility.h"


@implementation XFUtility

+ (UIButton *)xf_createBtnWithBackgroundImag:(UIImage *)image  {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, navBackBtnWidth, navBackBtnHeght);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    return btn;
}

+ (UILabel *)xf_createLabelWithTitle:(NSString *)title {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, SCREEN.width , 40);
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
    titleLabel.textColor = [UIColor blueColor];
    
    return titleLabel;
}


@end
