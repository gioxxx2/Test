//
//  OrderFooterView.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/22.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import "OrderFooterView.h"

@interface OrderFooterView ()
@property (weak, nonatomic) IBOutlet UILabel *PayTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *OrderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UIView *LineV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceLabelWidth;
@property (weak, nonatomic) IBOutlet UILabel *memoLabel;

@end

@implementation OrderFooterView


+ (OrderFooterView *)orderFooterViewWithproductOrder:(productOrder *)productOrder{
    UINib *nib = [UINib nibWithNibName:@"OrderFooterView" bundle:nil];
    OrderFooterView *orderFV = [nib instantiateWithOwner:nil options:nil][0];
    orderFV.LineV.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    if ([productOrder.payType isEqualToString:@"UPMP"]) {
        orderFV.PayTypeLabel.text = @"银联支付";
    }else{
        orderFV.PayTypeLabel.text = @"支付宝支付";
    }
    float money = [productOrder.money floatValue]/100;
    float express = [productOrder.express floatValue]/100;
    if (money > 10) {
        orderFV.PriceLabel.text = [NSString stringWithFormat:@"￥%.0f(含运费￥%.0f)",money,express];
        
        
    }else{
        orderFV.PriceLabel.text = [NSString stringWithFormat:@"￥%.2f(含运费￥%.2f)",money,express];
    }
    CGSize size = [orderFV.PriceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    orderFV.OrderTimeLabel.text = productOrder.createTime;
    orderFV.priceLabelWidth.constant = size.width+10;
    if (productOrder.memo) {
        orderFV.memoLabel.text = productOrder.memo;
    }else{
        orderFV.memoLabel.text = @"无";
    }
    return orderFV;
}

@end
