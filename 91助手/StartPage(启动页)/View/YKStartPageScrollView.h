//
//  YKStartPageScrollView.h
//  91助手
//
//  Created by xiaofan on 16/5/30.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YKStartPageScrollViewDelegate <NSObject>

- (void)startBtnClick;

@end

@interface YKStartPageScrollView : UIView

@property (nonatomic, assign) id <YKStartPageScrollViewDelegate> delegate;

- (void)setView;

@end
