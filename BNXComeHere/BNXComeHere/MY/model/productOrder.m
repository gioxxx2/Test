//
//  Order.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/21.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "product.h"
#import "productOrder.h"

@implementation productOrder


+ (instancetype)setUpOrderWithDic:(NSDictionary *)dic{
    return [[productOrder alloc]setUpOrderWithDic:dic];
}

- (instancetype)setUpOrderWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _orderId = dic[@"orderId"];
        _orderNo = dic[@"orderNo"];
        _payType = dic[@"payType"];
        _mobile = dic[@"mobile"];
        _createTime = dic[@"createTime"];
        _address = dic[@"address"];
        _county = dic[@"county"];
        _city = dic[@"city"];
        _province = dic[@"province"];
        _money = dic[@"money"];
        _receiveMan = dic[@"receiveMan"];
        _express = dic[@"express"];
        _memo = dic[@"memo"];
        _productArray = [NSMutableArray array];
        NSDictionary *pro = dic[@"products"];
        NSDictionary *oils = dic[@"oils"];
        NSDictionary *wines = dic[@"wines"];
        NSDictionary *gifts = dic[@"gifts"];
        
        NSArray *proArr = pro[@"products"];
        NSArray *oilArr = oils[@"products"];
        NSArray *winesArr = wines[@"products"];
        NSArray *giftArr = gifts[@"products"];
        for (NSDictionary *proDic in proArr) {
            product *pro = [product setupProdtctWithDic:proDic];
            [_productArray addObject:pro];
        }
        for (NSDictionary *oilDic in oilArr) {
            product *pro = [product setupProdtctWithDic:oilDic];
            [_productArray addObject:pro];
        }
        for (NSDictionary *wineDic in winesArr) {
            product *pro = [product setupProdtctWithDic:wineDic];
            [_productArray addObject:pro];
        }
        for (NSDictionary *giftDic in giftArr) {
            product *pro = [product setupProdtctWithDic:giftDic];
            [_productArray addObject:pro];
        }
    }
    return self;
}

@end
