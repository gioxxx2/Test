//
//  OrderFooterView.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/22.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "productOrder.h"
#import <UIKit/UIKit.h>

@interface OrderFooterView : UIView

+ (OrderFooterView *)orderFooterViewWithproductOrder:(productOrder*)productOrder;

@end
