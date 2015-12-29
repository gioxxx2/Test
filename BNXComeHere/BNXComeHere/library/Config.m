//
//  Config.m
//  WanXiao
//
//  Created by 李金华 on 15/5/11.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "Config.h"


@implementation Config
/**
 *  压缩图片
 *
 *  @param img 原始图片对象
 *
 *  @return 压缩后图片
 */
+(UIImage *)compressImage:(UIImage *)img
{

    NSData * data = UIImageJPEGRepresentation(img, 1);
    
    NSLog(@"%lu",(unsigned long)data.length);//压缩后图片数据的长度
    
    return [UIImage imageWithData:data];
}
/**
 *  将字典转json
 *
 *  @param dic 字典对象
 *
 *  @return 返回json
 */
+(NSString*)getJsonStr:(NSDictionary*)dic{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    
    
    if ([jsonData length] > 0 && error == nil){
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                
                                                     encoding:NSUTF8StringEncoding];
        
        return jsonString;
        
    }else{
        
        return nil;
        
    }
    
    
}
/**
 *  给定尺寸重新绘制图片的大小
 *
 *  @param image   原始图片
 *  @param newSize 要绘制图片的大小
 *
 *  @return 返回重新绘制的图片
 */
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
/**
 *  第三方进度条显示
 *
 *  @param str  提示加载文字
 *  @param view 要显示的视图
 */
+(void)showMBProgress:(NSString *)str withView:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].keyWindow];
    [view addSubview:hud];
    hud.labelText = str;
    [hud show:YES];
}
/**
 *  第三方进度条消失
 *
 *  @param view 进度条所在的视图
 */
+(void)dismissMBProgressWithView:(UIView *)view
{
    UIView *viewToRemove = nil;
    for (UIView *v in [view subviews])
    {
        if ([v isKindOfClass:[MBProgressHUD class]])
        {
            viewToRemove = v;
        }
    }
    if (viewToRemove != nil)
    {
        MBProgressHUD *hud = (MBProgressHUD *)viewToRemove;
        [hud hide:YES];
        [hud removeFromSuperViewOnHide];
        hud = nil;
    }
}
/**
 *  弹出视图
 *
 *  @param title   标题
 *  @param message 详细信息
 */
+(void) showAlertWith:(NSString *)title andMessage:(NSString *)message
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
/**
 *  时间格式转换
 *
 *  @param ts 以s为单位的时间
 *
 *  @return 返回转化后的时间字符串
 */
+(NSString *)tranfromTime:(long long)ts
{
    NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:ts];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strTime=[formatter stringFromDate:date];
    return strTime;
}
/**
 *  手机号码验证
 *
 *  @param mobileNum 手机号码
 *
 *  @return 返回验证结果
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
