//
//  YKOtherTableViewCell.m
//  91助手
//
//  Created by xiaofan on 16/6/6.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKOtherTableViewCell.h"


#define IMG_BASE_TAG 100

@interface YKOtherTableViewCell ()

@property (nonatomic, weak) UIImageView *imgView;

@property (nonatomic, assign) CGFloat far;

@end


@implementation YKOtherTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    CGFloat far = 15;
    self.far = far;
    CGFloat ffar = far / 3;
    
    NSURL *url1 = [NSURL URLWithString:@"http://bcs.91.com/rbpiczy/tagpic/2015/10/c0039f00f28a48159b9c6455e3fc7313_294_640x256.jpg"];
    NSURL *url2 = [NSURL URLWithString:@"http://bcs.91.com/rbpiczy/tagpic/2015/10/42b773e2c87b485b9a4c7e2669935b73_294_640x256.jpg"];
    NSURL *url3 = [NSURL URLWithString:@"http://bcs.91.com/rbpiczy/tagpic/2015/10/b1e014827a004ab0b8ad9220db23bbd1_294_640x256.jpg"];
    NSURL *url4 = [NSURL URLWithString:@"http://bcs.91.com/rbpiczy/tagpic/2015/10/f20a687d833649dead069214a48345b4_294_640x256.jpg"];
    NSArray *urlArray = @[url1, url2, url3, url4];
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        CGFloat imgViewW = (SCREEN.width - far * 2 - ffar) / 2;
        CGFloat imgViewH = 90;
        CGFloat imgViewX = far + ffar * (i % 2) + imgViewW * (i % 2);
        CGFloat imgViewY = far + ((ffar * (i / 2) + imgViewH * (i / 2)));
        imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
        imgView.layer.cornerRadius = 3.0;
        imgView.clipsToBounds = YES;
        [imgView sd_setImageWithURL:urlArray[i] placeholderImage:[UIImage imageNamed:@"bg_allsproutpop_dropdown"]];
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
    
    self.rowHeight = CGRectGetMaxY(self.imgView.frame) + far;
}

- (void)tap:(UITapGestureRecognizer *)sender {
    UIImageView *imgView = (UIImageView *)sender.view;
    if ([self.delegate respondsToSelector:@selector(imgViewTapIndex:)]) {
        [self.delegate imgViewTapIndex:imgView.tag - IMG_BASE_TAG];
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
