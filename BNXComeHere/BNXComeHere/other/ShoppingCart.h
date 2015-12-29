//
//  ShoppingCart.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/16.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCart : NSObject
//存放商品的字典
@property (nonatomic,retain)NSMutableDictionary *dataDic;

+ (instancetype)shareShoppingCart;
- (NSInteger)countAllKindProductInShoppingCart;
//- (id)productAtIndex:(NSInteger)index;
//- (NSInteger)indexOfProduct:(id)product;
- (NSMutableArray *)arrayOfShoppingCartWithProductId:(NSString *)productId;
- (NSArray *)allKeyOfDataDic;

- (NSInteger)countOfAllValueArrayCount;

@end
