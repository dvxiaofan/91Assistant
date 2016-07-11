//
//  YKScrollPagingView.h
//  Login-Demo
//
//  Created by 张张张小烦 on 16/5/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKApp;

// 定义一个代理方法
@protocol YKScrollPagingViewDelegate <NSObject>

- (void)scrollPagingViewImageTapIndex:(NSInteger)index;

@end

@interface YKScrollPagingView : UIView
// 声明代理属性
@property (nonatomic, assign) id <YKScrollPagingViewDelegate> delegate;


/** app */
@property (nonatomic, strong) YKApp *app;

/** newArray */
@property (nonatomic, strong) NSArray <YKApp *>*ScrollImgArray;

/** newArray */
//@property (nonatomic, strong) NSMutableArray *urlArray;


//- (void)setImageView;


@end
