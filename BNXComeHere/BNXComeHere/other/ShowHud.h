//
//  ShowHud.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "MBProgressHUD.h"
#import <Foundation/Foundation.h>

@interface ShowHud : NSObject

+ (instancetype)shareHud;

- (void)showLoadHud;

- (void)showHide;

- (void)showHudWithText:(NSString *)text;

- (void)showErrorWithinfo:(NSString *)info controller:(UIViewController *)controller;

@end
