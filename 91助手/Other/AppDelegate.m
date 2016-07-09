//
//  AppDelegate.m
//  91助手
//
//  Created by 小烦 on 16/5/27.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "AppDelegate.h"
#import "YKRootViewController.h"
#import "YKStartPageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    // 根据当前版本信息，判断是否显示开始页面
    // 保存版本信息
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    docPath = [docPath stringByAppendingPathComponent:@"version.plist"];
    // 保存版本号的字典
    NSDictionary *versionDict = [NSBundle mainBundle].infoDictionary;
    // 获得当前版本号
    NSString *currentVersion = versionDict[@"CFBundleVersion"];
    // 获得上次的版本号
    NSMutableDictionary *oldVersionDict = [NSMutableDictionary dictionaryWithContentsOfFile:docPath];
    // 老版存在，不是第一次安装
    if (oldVersionDict) {
        // 判断是否与当前版本号一致   先获得老版本号
        NSString *oldVersion = oldVersionDict[@"CFBundleVersion"];
        // 相同，不显示开始页  且不用保存当前版本号
        if ([currentVersion isEqualToString:oldVersion]) {
            YKRootViewController *rootVC = [[YKRootViewController alloc] init];
            self.window.rootViewController = rootVC;
        } else { // 不相同 显示
            YKStartPageViewController *startVC = [[YKStartPageViewController alloc] init];
            self.window.rootViewController = startVC;
            // 保存当前版本号
            oldVersionDict[@"CFBundleVersion"] = currentVersion;
            [oldVersionDict writeToFile:docPath atomically:YES];
        }
    } else {  // 老版本不存在，是第一次安装  显示
        YKStartPageViewController *startVC = [[YKStartPageViewController alloc] init];
        self.window.rootViewController = startVC;
        
        // 构建版本字典  并保存当前版本到文件
        NSMutableDictionary *versionDict = [NSMutableDictionary dictionary];
        versionDict[@"CFBundleVersion"] = currentVersion;
        [versionDict writeToFile:docPath atomically:YES];
    }
    
    
    
    // 自定义tabbar背景颜色
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_background"]]];
    

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
