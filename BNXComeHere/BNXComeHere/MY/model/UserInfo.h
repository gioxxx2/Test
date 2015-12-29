//
//  UserInfo.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
//账号
@property (nonatomic,retain)NSString *account;
//详细地址
@property (nonatomic,retain)NSString *address;
//金额
@property (nonatomic,assign)NSInteger cash;
//头像id
@property (nonatomic,retain)NSString *avatarId;
//市
@property (nonatomic,retain)NSString *city;
//区
@property (nonatomic,retain)NSString *county;
//创建时间
@property (nonatomic,retain)NSString *createTime;
//邮箱
@property (nonatomic,retain)NSString *email;
//我的会员
@property (nonatomic,assign)NSInteger membercount;
//手机号
@property (nonatomic,retain)NSString *mobile;
//余额
@property (nonatomic,assign)NSInteger money;
//省
@property (nonatomic,retain)NSString *province;
//推荐人数
@property (nonatomic,assign)NSInteger refercount;
//会员总数
@property (nonatomic,assign)NSInteger memberTotal;
//收件人
@property (nonatomic,retain)NSString *receiveMan;
//时间戳
@property (nonatomic,retain)NSString *timestamp;
//令牌
@property (nonatomic,retain)NSString *token;
//用户ID
@property (nonatomic,retain)NSString *userId;
//账号
@property (nonatomic,retain)NSString *UserAcount;
//密码
@property (nonatomic,retain)NSString *UserPassword;
@property (nonatomic,retain)NSString *referId;

//头像路径
@property (nonatomic,retain)NSString *iconFilePath;
// 会员级别
@property (nonatomic,retain)NSString *property;
//二维码
@property (nonatomic,retain)UIImage *QRCodeImage;

+ (UserInfo *)shareUserInfo;

- (void)setUpWithNewDic:(NSDictionary *)dic;

- (void)updateUserInfo;

@end
