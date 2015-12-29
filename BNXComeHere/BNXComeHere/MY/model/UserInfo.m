//
//  UserInfo.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "UIImage+LXDCreateBarcode.h"
#import "AFHTTPRequestOperationManager.h"
#import "UserInfo.h"

@interface UserInfo ()
////账号
//@property (nonatomic,retain)NSString *account;
////详细地址
//@property (nonatomic,retain)NSString *address;
////金额
//@property (nonatomic,retain)NSString *cash;
////头像id
//@property (nonatomic,retain)NSString *avatarId;
////市
//@property (nonatomic,retain)NSString *city;
////区
//@property (nonatomic,retain)NSString *county;
////创建时间
//@property (nonatomic,retain)NSString *createTime;
////邮箱
//@property (nonatomic,retain)NSString *email;
////我的会员
//@property (nonatomic,retain)NSString *membercount;
////手机号
//@property (nonatomic,retain)NSString *mobile;
////余额
//@property (nonatomic,retain)NSString *money;
////省
//@property (nonatomic,retain)NSString *province;
////推荐人数
//@property (nonatomic,retain)NSString *refercount;
////会员总数
//@property (nonatomic,retain)NSString *memberTotal;
////收件人
//@property (nonatomic,retain)NSString *receiveMan;
////时间戳
//@property (nonatomic,retain)NSString *timestamp;
////令牌
//@property (nonatomic,retain)NSString *token;
////用户ID
//@property (nonatomic,retain)NSString *userId;
////账号
//@property (nonatomic,retain)NSString *UserAcount;
////密码
//@property (nonatomic,retain)NSString *UserPassword;
@end

@implementation UserInfo

+ (UserInfo *)shareUserInfo{
    static UserInfo *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[UserInfo alloc]init];
        NSLog(@"用户信息初始化");
        NSDictionary *userDataDic = [[NSUserDefaults standardUserDefaults] objectForKey:UserData];
        [info setValuesForKeysWithDictionary:userDataDic];
        info.UserAcount = [[NSUserDefaults standardUserDefaults] objectForKey:USERName];
      

       
    });
  
    return info;
}

- (void)setUpWithNewDic:(NSDictionary *)dic{
    UserInfo *info = [UserInfo shareUserInfo];
    [info setValuesForKeysWithDictionary:dic];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSString *)property{
    if ([_property isEqualToString:@"member"]) {
        _property = @"普通会员";
    }else if ([_property isEqualToString:@"VIP"]){
        _property = @"VIP会员";
    }else if ([_property isEqualToString:@"manage"]){
        _property = @"管理公司";
    }else if ([_property isEqualToString:@"NORMAL"]){
        _property = @"普通E站";
    }else if ([_property isEqualToString:@"CITY"]){
        _property = @"市级E站";
    }else if ([_property isEqualToString:@"PROVINCE"]){
        _property = @"省级E站";
    }else if ([_property isEqualToString:@"COUNTY"]){
        _property = @"县级E站";
    }
    return _property;
}

- (void)updateUserInfo{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [UserInfo shareUserInfo].token;
    param[@"userId"] = [UserInfo shareUserInfo].userId;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:UserinfoUpdateUrl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            
            
            NSDictionary *data = responseObject[@"data"];
            
            [[UserInfo shareUserInfo] setUpWithNewDic:data];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (UIImage *)QRCodeImage{
    
    return [UIImage imageOfQRFromURL:userQRCodeUrl codeSize:160 red:0 green:0 blue:0 insertImage:[UIImage imageNamed:@"icon"] roundRadius:15.0f];
}



@end
