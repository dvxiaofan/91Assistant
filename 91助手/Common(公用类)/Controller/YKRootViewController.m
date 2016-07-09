//
//  YKRootViewController.m
//  91助手
//
//  Created by xiaofan on 16/5/30.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKRootViewController.h"
#import "YKHomeViewController.h"
#import "YKChatViewController.h"
#import "YKClassifyViewController.h"
#import "YKSearchViewController.h"
#import "YKNavgationController.h"

@interface YKRootViewController ()

@end

@implementation YKRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initViewController];
    
}

- (void)initViewController {
    YKHomeViewController *homeVC = [[YKHomeViewController alloc] init];
    [self addChildWithController:homeVC
                           title:@"首页"
                 normalImageName:@"homepage_home"
               selectedImageName:@"homepage_home_sel"];
    
    YKChatViewController *chatVC = [[YKChatViewController alloc] init];
    [self addChildWithController:chatVC
                           title:@"聊吧"
                 normalImageName:@"homepage_talk"
               selectedImageName:@"homepage_talk_sel"];
    
    YKClassifyViewController *classifyVC = [[YKClassifyViewController alloc] init];
    [self addChildWithController:classifyVC
                           title:@"分类"
                 normalImageName:@"homepage_cate"
               selectedImageName:@"homepage_cate_sel"];
    
    YKSearchViewController *searchVC = [[YKSearchViewController alloc] init];
    [self addChildWithController:searchVC
                           title:@"搜索"
                 normalImageName:@"homepage_seach"
               selectedImageName:@"homepage_seach_sel"];

    NSArray *vcArray = @[homeVC, chatVC, classifyVC, searchVC];
    
    NSMutableArray *navMuArray = [[NSMutableArray alloc] initWithCapacity:vcArray.count];
    
    for (NSInteger i = 0; i < vcArray.count; i++) {
        YKNavgationController *nav = [[YKNavgationController alloc] initWithRootViewController:vcArray[i]];
        
        [navMuArray addObject:nav];
    }
    self.viewControllers = navMuArray;
}

- (void)addChildWithController:(UIViewController *)childVC title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName {
    childVC.title = title;
    
    // 修改默认字体颜色
    NSMutableDictionary *dicNormal = [NSMutableDictionary dictionary];
    dicNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    [childVC.tabBarItem setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
    
    // 修改点击选中字体颜色
    NSMutableDictionary *dicSelected = [NSMutableDictionary dictionary];
    dicSelected[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    
    // 设置tabbar默认背景图片
    childVC.tabBarItem.image = [UIImage imageNamed:normalImageName];
    
    // 修改点击选中状态的背景图片
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 阻止tabbar对图片进行默认渲染
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = selectedImage;
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
