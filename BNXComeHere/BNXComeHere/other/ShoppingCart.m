//
//  ShoppingCart.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/16.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import "ShoppingCart.h"

@implementation ShoppingCart


+ (instancetype)shareShoppingCart{
    static ShoppingCart *shop = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shop = [[ShoppingCart alloc]init];
    });
    return shop;
}


- (NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}


- (NSInteger)countAllKindProductInShoppingCart{
    return self.dataDic.allKeys.count;
}

- (NSMutableArray *)arrayOfShoppingCartWithProductId:(NSString *)productId{
    NSArray *arr = self.dataDic.allKeys;
    for (NSString *str in arr) {
        if ([productId isEqualToString:str]) {
            return self.dataDic[str];
        }
    }
    return 0;
}

- (NSInteger)countOfAllValueArrayCount{
    NSInteger count = 0;
    for (NSString *key in self.dataDic.allKeys) {
        NSArray *valueArr = self.dataDic[key];
        count += valueArr.count;
    }
    return count;
}

- (NSArray *)allKeyOfDataDic{
    return self.dataDic.allKeys;
}

//- (id)productAtIndex:(NSInteger)index{
//    return self.dataArray[index];
//}
//
//- (NSInteger)indexOfProduct:(id)product{
//    return [self.dataArray indexOfObject:product];
//}


@end
