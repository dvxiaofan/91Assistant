//
//  YKRowsTableViewCell.m
//  91助手
//
//  Created by xiaofan on 16/6/6.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKRowsTableViewCell.h"
#import "YKStarView.h"
#import "NSString+YKExtension.h"
#import "YKSingleRowApp.h"

#define APP_NAME_FONT [UIFont systemFontOfSize:13.0]
#define APP_NAME_COLOR [UIColor blackColor]

#define CELL_INFO_FONT [UIFont systemFontOfSize:11.0]
#define CELL_INFO_COLOR [UIColor grayColor]

@interface YKRowsTableViewCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) YKStarView *starView;
@property (nonatomic, weak) UILabel *downNumLabel;
@property (nonatomic, weak) UILabel *fileSizeLabel;
@property (nonatomic, weak) UIButton *downBtn;



@property (nonatomic, assign) CGFloat far;              // 固定间隔
/** manager */
@property (nonatomic, strong) XFHTTPSessionManager *manager;

///** ss */
//@property (nonatomic, strong) NSMutableArray <YKSingleRowApp *>*apps;

@end

@implementation YKRowsTableViewCell

- (XFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [XFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
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
    
    ////YKLog(@"uu = %@", self.url);
    
    
    //__weak typeof(self) weakSelf = self;
    
    //[self.manager GET:HOME_EDITOR_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ////NSArray *singleRowApps = [YKSingleRowApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"items"]];
        //weakSelf.apps = [YKSingleRowApp mj_objectArrayWithKeyValuesArray:responseObject[@"Result"][@"items"]];
    
        
        [self createApp];
        
    //} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //YKLog(@"error:%@", error);
        
    //}];
}

#pragma mark - UI布局

- (void)createApp {
    CGFloat far = 15;
    self.far = far;
    //图标
    UIImageView *iconView = [[UIImageView alloc] init];
    CGFloat iconViewX = far;
    CGFloat iconViewY = far / 2;
    iconView.frame = CGRectMake(iconViewX, iconViewY, ICONVIEW_WH, ICONVIEW_WH);
    [self addSubview:iconView];
    self.iconView = iconView;
    //名字
    UILabel *nameLabel = [[UILabel alloc] init];
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + far;
    CGFloat nameY = iconViewY + 3;
    CGFloat nameW = SCREEN.width - ICONVIEW_WH * 3;
    CGFloat nameH = 18;
    nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    //星级评级
    YKStarView *starView = [[YKStarView alloc] init];
    CGFloat starY = CGRectGetMaxY(self.nameLabel.frame) + 3;
    CGFloat starW = 100;
    CGFloat starH = 20;
    starView.frame = CGRectMake(nameX, starY, starW, starH);
    [self addSubview:starView];
    self.starView = starView;
    //下载次数
    UILabel *downNumLabel = [[UILabel alloc] init];
    CGFloat downNumY = CGRectGetMaxY(self.starView.frame) + 3;
    CGSize downNumSize = [downNumLabel.text sizeWithFont:downNumLabel.font];
    
    downNumLabel.frame = CGRectMake(nameX, downNumY, downNumSize.width, downNumSize.height);
    [self addSubview:downNumLabel];
    self.downNumLabel = downNumLabel;
    //APP 大小
    UILabel *fileSizeLabel = [[UILabel alloc] init];
    CGFloat fileX = CGRectGetMaxX(self.downNumLabel.frame) + 10;
    CGSize fileSize = [fileSizeLabel.text sizeWithFont:fileSizeLabel.font];
    fileSizeLabel.frame = CGRectMake(fileX, downNumY, fileSize.width, fileSize.height);
    [self addSubview:fileSizeLabel];
    self.fileSizeLabel = fileSizeLabel;
    //下载按钮
    UIButton *downBtn = [[UIButton alloc] init];
    CGFloat btnX = CGRectGetMaxX(self.nameLabel.frame) + far + 5;
    CGFloat btnY = far * 2;
    CGFloat btnW = 55;
    CGFloat btnH = 25;
    downBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [self addSubview:downBtn];
    self.downBtn = downBtn;
    
    self.rowHeight = CGRectGetMaxY(self.downNumLabel.frame) + far / 2;
    
}

- (void)setApps:(YKSingleRowApp *)apps {
    _apps = apps;
    
    // appname
    self.nameLabel.text = apps.name;
    self.nameLabel.font = APP_NAME_FONT;
    self.nameLabel.textColor = APP_NAME_COLOR;
    
    // 星级评价
    self.starView.showStar = apps.star * 20;
    
    // 图标
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:apps.icon] placeholderImage:[UIImage imageNamed:@"250_250_pic"]];
    self.iconView.layer.cornerRadius = 8.0;
    self.iconView.clipsToBounds = YES;
    
    // 下载次数
    self.downNumLabel.text = [NSString stringWithFormat:@"%@下载", apps.downTimes];
    self.downNumLabel.font = CELL_INFO_FONT;
    self.downNumLabel.textColor = CELL_INFO_COLOR;
    
    // 应用大小
    CGFloat fileSize = apps.size / 1024.0 / 1024.0;
    self.fileSizeLabel.text = [NSString stringWithFormat:@"%.2fMB", fileSize];
    self.fileSizeLabel.textColor = CELL_INFO_COLOR;
    self.fileSizeLabel.font = CELL_INFO_FONT;
    
    // 下载按钮
    if ([apps.price isEqualToString:@"0.00"]) {
        [self.downBtn setTitle:@"免费" forState:UIControlStateNormal];
        [self.downBtn setBackgroundColor:[UIColor orangeColor]];
        [self.downBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self.downBtn setTitle:apps.price forState:UIControlStateNormal];
        [self.downBtn setBackgroundColor:[UIColor whiteColor]];
        [self.downBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.downBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.downBtn.layer.cornerRadius = 3.0;
    self.downBtn.clipsToBounds = YES;
    
}

#pragma mark - 下载点击事件

- (void)btnClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(rowsTableViewCell:)]) {
        [self.delegate rowsTableViewCell:self];
    }
}

//- (void)setFrame:(CGRect)frame {
    //YKLogFunc
//}

- (void)layoutSubviews {
    CGFloat far = 15;
    // 图标
    
    
    //名字
    
    
    //星级评价
    
    
    //下砸次数
    
    
    //应用大小
    
    
    //下载按钮
    
    
    
    
}



@end












