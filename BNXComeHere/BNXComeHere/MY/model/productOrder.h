//
//  Order.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/21.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface productOrder : NSObject
//订单id
@property (nonatomic,retain)NSString *orderId;
//订单号
@property (nonatomic,retain)NSString *orderNo;
//支付类型
@property (nonatomic,retain)NSString *payType;
//支付手机号
@property (nonatomic,retain)NSString *mobile;
//产品数组
@property (nonatomic,retain)NSMutableArray *productArray;
//购买时间
@property (nonatomic,retain)NSString *createTime;
//详细地址
@property (nonatomic,retain)NSString *address;
//区
@property (nonatomic,retain)NSString *county;
//市
@property (nonatomic,retain)NSString *city;
//省
@property (nonatomic,retain)NSString *province;
//价格
@property (nonatomic,retain)NSString *money;
//收件人
@property (nonatomic,retain)NSString *receiveMan;
//运费
@property (nonatomic,retain)NSString *express;
//备注信息
@property (nonatomic,retain)NSString *memo;



- (instancetype)setUpOrderWithDic:(NSDictionary *)dic;
+ (instancetype)setUpOrderWithDic:(NSDictionary *)dic;

@end
