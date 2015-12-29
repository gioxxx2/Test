//
//  SIAlertView+Normal.m
//  BigMouthMall
//
//  Created by mac on 14-1-20.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SIAlertView+Normal.h"

@implementation SIAlertView (Normal)
+(SIAlertView *) normalAlertViewWithMessage:(NSString *)message
{
    return [SIAlertView normalAlertViewWithTitle:NormalAlertTitle Message:message];
}

+(SIAlertView *) normalAlertViewWithTitle:(NSString *)title Message:(NSString *)message
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    alertView.backgroundStyle = SIAlertViewBackgroundStyleGradient;
    return alertView;
}

-(void) addOKButtonWithHandler:(SIAlertViewHandler)handler
{
    [self addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:handler];
}

-(void) addCancelButtonWithHandler:(SIAlertViewHandler)handler
{
    [self addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:handler];
}

-(void) addOtherButtonTitle:(NSString *)title Handler:(SIAlertViewHandler)handler
{
    [self addButtonWithTitle:title type:SIAlertViewButtonTypeDefault handler:handler];
}
@end
