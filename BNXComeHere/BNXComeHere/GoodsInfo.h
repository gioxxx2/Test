//
//  GoodsInfo.h
//  BNXComeHere
//
//  Created by 陈华军 on 15/11/19.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsInfo : NSObject<NSCoding>

@property(strong, nonatomic) NSString * goodsName;//商品名称
@property(strong, nonatomic) NSString * goodsPrice;//商品价格
@property(assign, nonatomic) int goodsCount;//商品数量
@property(strong, nonatomic) UIImageView * goodsImage;//商品图片


@end
