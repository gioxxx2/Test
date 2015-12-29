//
//  product.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/14.
//  Copyright © 2015年 linyj. All rights reserved.
// 商品model

#import <Foundation/Foundation.h>

@interface product : NSObject<NSMutableCopying>
//购买次数
@property (nonatomic,retain)NSString *buyCount;
//价格
@property (nonatomic,retain)NSString *price;
//商品ID
@property (nonatomic,retain)NSString *productId;
//商品名字
@property (nonatomic,retain)NSString *productName;
//商品类型
@property (nonatomic,retain)NSString *vendor;
//会员价格
@property (nonatomic,retain)NSString *memberPrice;
//描述
@property (nonatomic,retain)NSString *desc;
//运费
@property (nonatomic,retain)NSString *express;
//图片id 数组
@property (nonatomic,retain)NSMutableArray *pics;
//库存
@property (nonatomic,retain)NSString *amount;
//状态
@property (nonatomic,retain)NSString *status;

- (instancetype)setupProdtctWithDic:(NSDictionary *)dic;
+ (instancetype)setupProdtctWithDic:(NSDictionary *)dic;


@end
