//
//  orderDetailHeaderView.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/21.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "productOrder.h"
#import <UIKit/UIKit.h>

@interface orderDetailHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame order:(productOrder *)order;
+ (instancetype)initWithFrame:(CGRect)frame order:(productOrder *)order;

@end
