//
//  SIAlertView+Normal.h
//  BigMouthMall
//
//  Created by mac on 14-1-20.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SIAlertView.h"

#define  NormalAlertTitle @"来我这"

@interface SIAlertView (Normal)
//创建默认样式默认Title的SIAlertView
+(SIAlertView *) normalAlertViewWithMessage:(NSString *)message;

//创建默认样式的SIAlertView
+(SIAlertView *) normalAlertViewWithTitle:(NSString *)title Message:(NSString *)message;

//添加默认样式的确定按钮
-(void) addOKButtonWithHandler:(SIAlertViewHandler)handler;

//添加默认样式的取消按钮
-(void) addCancelButtonWithHandler:(SIAlertViewHandler)handler;

//添加默认样式的其他按钮
-(void) addOtherButtonTitle:(NSString *)title Handler:(SIAlertViewHandler)handler;
@end
