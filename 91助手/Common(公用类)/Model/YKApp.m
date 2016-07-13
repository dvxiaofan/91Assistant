//
//  YKApp.m
//  91助手
//
//  Created by xiaofans on 16/6/21.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKApp.h"

@implementation YKApp

- (CGFloat)singleCellHeight {
    _singleCellHeight = YKMargin * 2 + YKAppWH + YKSmallMargin;
    
    return _singleCellHeight;
}

- (CGFloat)rowsCellHeight {
    _rowsCellHeight = YKMargin + YKAppWH;
    
    return _rowsCellHeight;
}

- (CGFloat)appCellHeight {
    _appCellHeight = YKSmallSpace * 2 + SCREEN.width * 7 / 16 + YKMargin + YKMargin;
    
    return _appCellHeight;
}

@end
