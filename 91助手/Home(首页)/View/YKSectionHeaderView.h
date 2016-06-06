//
//  YKSectionHeaderView.h
//  91助手
//
//  Created by xiaofan on 16/6/6.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YKSectionHeaderViewDelegate;

@interface YKSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) NSString *text;

@property (nonatomic, assign) id <YKSectionHeaderViewDelegate> delegate;

@end

@protocol YKSectionHeaderViewDelegate <NSObject>

- (void)sectionHeaderView:(YKSectionHeaderView *)view;

@end