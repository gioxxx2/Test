//
//  AppDelegate.m
//  BNXComeHere
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 linyj. All rights reserved.
//
#import "WBNewFeatureVC.h"
#import "UserInfo.h"
#import "WBTool.h"
#import "BNXTabBarController.h"
#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import <ShareSDK/ShareSDK.h>

#import "WXApi.h"


#import "ViewController.h"

#import "InvestViewController.h"
#import "MemberViewController.h"
#import "MYViewController.h"

#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //注册shareSDK
    [ShareSDK registerApp:@"11efbd710b38"];
    
    
    
    //分享到微信
    [ShareSDK connectWeChatWithAppId:@"wx71b1ac4e06c7c9de" wechatCls:[WXApi class]];
    
    
    
    
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    


    [WBTool chooseRootController];

    

    
    
    
    
    

    
    
    return YES;
}





#pragma mark --------------------------ShareSDK初始化-----------------
-(void)setShareSDK{
    
    [ShareSDK registerApp:ShareSdkAppKey];
    
    //    //添加新浪微博应用 注册网址 http://open.weibo.com
    //    [ShareSDK connectSinaWeiboWithAppKey:SinaWeiBoAppKey
    //                               appSecret:SinaWeiBoAppSecret
    //                             redirectUri:@"http://www.sharesdk.cn"];
    
    
    //添加微信应用  http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:WeChatAppId
                           appSecret:WeChatAppSecret
                           wechatCls:[WXApi class]];
    
}



-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    //    return [WXApi handleOpenURL:url delegate:self];
    
    
    if ([ShareSDK handleOpenURL:url wxDelegate:self]) {
        return YES;
    }
    return YES;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"+++result = %@",resultDic);
    }];
//    [WXApi handleOpenURL:url delegate:self]
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
