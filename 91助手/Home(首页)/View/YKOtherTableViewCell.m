//
//  YKOtherTableViewCell.m
//  91助手
//
//  Created by xiaofan on 16/6/6.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKOtherTableViewCell.h"
#import "YKApp.h"


#define IMG_BASE_TAG 100

@interface YKOtherTableViewCell ()

@property (nonatomic, weak) UIImageView *imgView;

/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

@end


@implementation YKOtherTableViewCell

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

/**
 *  初始化
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadNewData];
    }
    return self;
}

- (void)loadNewData {
    // 取消所有请求
    //[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //YKLog(@"uu = %@", self.url);
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:HOME_APP_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //YKWriteToPlist(responseObject, @"专题app");
        NSArray *apps = [YKApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        
        weakSelf.iconArray = [apps subarrayWithRange:NSMakeRange(0, 4)];
        
        [weakSelf createApp:weakSelf.iconArray];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error:%@", error);
        
    }];
}

#pragma mark - UI布局

- (void)createApp:(NSArray *)iconArray {
    
    NSInteger count = iconArray.count;
    
    for (int i = 0; i < count; i++) {
        
        _app = iconArray[i];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        CGFloat imgViewW = (SCREEN.width - YKMargin * 2 - YKMargin / 3) / 2;
        CGFloat imgViewH = 90;
        CGFloat imgViewX = YKMargin + (YKMargin / 3) * (i % 2) + imgViewW * (i % 2);
        CGFloat imgViewY = YKMargin + (((YKMargin / 3) * (i / 2) + imgViewH * (i / 2)));
        imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
        imgView.layer.cornerRadius = 3.0;
        imgView.clipsToBounds = YES;
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.app.icon] placeholderImage:[UIImage imageNamed:@"cent_banner_pic_n"]];
        
        [self addSubview:imgView];
        imgView.userInteractionEnabled = YES;
        imgView.tag = IMG_BASE_TAG + i;
        
        self.imgView = imgView;
        
        // 增加点击手势
        // 添加点击手势识别
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;       // 点击次数
        tap.numberOfTouchesRequired = 1;    // 点击手指数
        [imgView addGestureRecognizer:tap];

    }
    
    self.rowHeight = CGRectGetMaxY(self.imgView.frame) + YKMargin;
}

- (void)tap:(UITapGestureRecognizer *)sender {
    UIImageView *imgView = (UIImageView *)sender.view;
    if ([self.delegate respondsToSelector:@selector(imgViewTapIndex:)]) {
        [self.delegate imgViewTapIndex:imgView.tag - IMG_BASE_TAG];
    }
}




@end
