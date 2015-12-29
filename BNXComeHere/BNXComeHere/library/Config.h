//
//  Config.h
//  WanXiao
//
//  Created by 李金华 on 15/5/11.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface Config : NSObject

//字典转json
+(NSString*)getJsonStr:(NSDictionary*)dic;
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+(void)showMBProgress:(NSString *)str withView:(UIView *)view;
+(void)dismissMBProgressWithView:(UIView *)view;
+(void) showAlertWith:(NSString *) title andMessage:(NSString *) message;
+(NSString *)tranfromTime:(long long)ts;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+(UIImage *) compressImage:(UIImage *) img;
@end
