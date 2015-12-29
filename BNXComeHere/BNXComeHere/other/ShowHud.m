//
//  ShowHud.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "Reachability.h"
#import "ShowHud.h"

@implementation ShowHud

+ (instancetype)shareHud{
    static ShowHud *shop = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shop = [[ShowHud alloc]init];
    });
    return shop;
}

- (void)showLoadHud{
    NSMutableArray *imgs = [NSMutableArray array];
    for (int i = 0; i < 35; i++) {
        NSString *str = [NSString stringWithFormat:@"p%02d",i];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [imgs addObject:image];
    }
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.animationImages = imgs;
    imageV.animationRepeatCount = 0;
    imageV.animationDuration = 3;
    [imageV startAnimating];
    imageV.frame = CGRectMake(10, 10, 100, 100);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.tag = 1596;
    hud.customView = imageV;
    hud.mode = MBProgressHUDModeCustomView;
    
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
        {
           
            [hud hide:YES];
            MBProgressHUD *hudNoNet = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hudNoNet.mode = MBProgressHUDModeText;
            hudNoNet.labelText =  @"当前没有网络";
            [hudNoNet hide:YES afterDelay:2];
        }
            break;
        case ReachableViaWiFi:
        {
          
         
        }
            break;
        case ReachableViaWWAN:
        {
           
          
        }
            break;
        default:
            break;
    }
    
}

- (void)showHide{
    MBProgressHUD *hud = (MBProgressHUD *)[[UIApplication sharedApplication].keyWindow viewWithTag:1596];
    [hud hide:YES];
}


- (void)showHudWithText:(NSString *)text{
    MBProgressHUD *hud = (MBProgressHUD *)[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
    [hud hide:YES afterDelay:2];
}


- (void)showErrorWithinfo:(NSString *)info controller:(UIViewController *)controller{
    NSString *str = nil;
    if ([info isEqualToString:@"SE_1000"]) {
        str = @"前台异常";
    }else if ([info isEqualToString:@"SE_1001"]){
        str = @"服务器异常";
    }else if ([info isEqualToString:@"E_1000"]){
        str = @"Token 已失效";
    }else if ([info isEqualToString:@"E_1001"]){
        str = @"验证码不正确";
    }
    else if ([info isEqualToString:@"E_1002"]){
        str = @"验证码未过期,无法重新获取";
    }
    else if ([info isEqualToString:@"CE_1000"]){
        str = @"手机号为空";
    }
    else if ([info isEqualToString:@"CE_1001"]){
        str = @"手机格式不正确";
    }
    else if ([info isEqualToString:@"CE_1002"]){
        str = @"手机号已存在";
    }
    else if ([info isEqualToString:@"CE_1003"]){
        str = @"手机号不存在";
    }else if ([info isEqualToString:@"CE_1004"]){
        str = @"账户已存在";
    }else if ([info isEqualToString:@"CE_1005"]){
        str = @"账户不存在";
    }else if ([info isEqualToString:@"CE_1006"]){
        str = @"密码不正确";
    }else if ([info isEqualToString:@"CE_1007"]){
        str = @"密码为空";
    }else if ([info isEqualToString:@"CE_1008"]){
        str = @"新密码与原密码不允许相同";
    }else if ([info isEqualToString:@"CE_1009"]){
        str = @"地址信息为空";
    }else if ([info isEqualToString:@"CE_1010"]){
        str = @"邮箱为空";
    }else if ([info isEqualToString:@"CE_1011"]){
        str = @"邮箱格式不正确";
    }else if ([info isEqualToString:@"CE_1012"]){
        str = @"邮箱与原邮箱不允许相同";
    }else if ([info isEqualToString:@"CE_1013"]){
        str = @"邮箱已存在";
    }else if ([info isEqualToString:@"CE_1014"]){
        str = @"新手机号与原手机号不允许相同";
    }else if ([info isEqualToString:@"CE_1015"]){
        str = @"订单商品为空";
    }
    
    
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:action];
    [controller presentViewController:alertC animated:YES completion:nil];

}



@end
