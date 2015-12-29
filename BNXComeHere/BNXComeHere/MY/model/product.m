//
//  product.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/14.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import "product.h"

@implementation product

+ (instancetype)setupProdtctWithDic:(NSDictionary *)dic{
    
    return [[product alloc] setupProdtctWithDic:dic];
}

- (instancetype)setupProdtctWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        
        _buyCount = dic[@"buyCount"];
        _price = dic[@"price"];
        _productId = dic[@"productId"];
        _productName = dic[@"productName"];
        _vendor = dic[@"vendor"];
        NSArray *pics = dic[@"pics"];
        _pics = [NSMutableArray array];
        for (NSDictionary *picdic in pics) {
            [_pics addObject:picdic[@"picId"]];
        }
        if (_pics.count == 0 && dic[@"picId"]) {
            [_pics addObject:dic[@"picId"]];
        }
        _amount = dic[@"amount"];
        _memberPrice = dic[@"memberPrice"];
        _desc = dic[@"desc"];
        _express = dic[@"express"];
        _status = dic[@"status"];
    }
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    product *pro = [[product alloc]init];
    pro.buyCount = _buyCount;
    pro.price = _price;
    pro.productId = _productId;
    pro.productName = _productName;
    pro.vendor = _vendor;
    pro.pics = _pics;
    pro.memberPrice = _memberPrice;
    pro.desc = _desc;
    pro.express = _express;
    pro.amount = _amount;
    return pro;
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}




@end
