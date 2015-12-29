//
//  WBTool.m
//  XzWeibo
//
//  Created by 徐智 on 15/11/4.
//  Copyright © 2015年 徐智. All rights reserved.
//
#import "UserInfo.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "BNXTabBarController.h"
#import "WBNewFeatureVC.h"
#import "WBTool.h"

@implementation WBTool

+ (void)chooseRootController{
    NSString *key = @"CFBundleVersion";
    //取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defualt = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defualt stringForKey:key];
    //获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        //显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        
        [WBTool chooseFisetController];
        
        
    }else{
        //新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[WBNewFeatureVC alloc]init];
        //存储新版本
        [defualt setObject:currentVersion forKey:key];
        //    同步
        [defualt synchronize];
    }

}

+ (void)chooseFisetController{
    LoginViewController * MainVC = [[LoginViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:MainVC];
    [nav setNavigationBarHidden:YES];
    if ([UserInfo shareUserInfo].account) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[BNXTabBarController alloc]init];
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }
}


@end
