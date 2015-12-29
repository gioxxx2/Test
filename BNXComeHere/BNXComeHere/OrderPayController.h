//
//  OrderPayController.h
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, PayTypeE) {
    PayTypeZhiFuBao,
    PayTypeYinLin
};

#import <UIKit/UIKit.h>
#import "AddressChangeViewController.h"
@interface OrderPayController : UIViewController

@property (nonatomic,retain)NSMutableDictionary *productDic;
@property (nonatomic,assign)BOOL isBuyFromShoppingCart;

@end
