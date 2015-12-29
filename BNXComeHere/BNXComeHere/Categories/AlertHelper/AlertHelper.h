//
//  AlertHelper.h
//  ControlManageSystemProject
//
//  Created by guan song on 14-7-30.
//  Copyright (c) 2014年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AlertHelper : NSObject
+(void) showAlert:(NSString *)title
       andMessage:(NSString *)message
      andDelegate:(id) delegate
       andButtons:(NSString *)cancelButtonTitle;
+(void) showAlert:(NSString *)title
       andMessage:(NSString *)message
      andDelegate:(id) delegate;
+(void) showConfirm:(NSString *) title
         andMessage:(NSString *)message
        andDelegate:(id) delegate;
+(void) showOneSecond:(NSString *)message andDelegate:(UIView *) superView;
//显示下载中。。。
+(void) showWaiting:(NSString *) title;
+(void) hideWaiting:(NSString *) title;

//-------------------------------Y.y补充--------------------------------
/**
 *  提示信息
 *
 *  @param message 要提示的文本信息
 *  @param YesOrNo 是否在主线程显示
 */
+(void)MyAlertShow:(NSString*)message andisMainTheard:(BOOL)YesOrNo;

@end
