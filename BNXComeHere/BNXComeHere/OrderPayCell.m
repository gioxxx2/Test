//
//  OrderPayCell.m
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "ShoppingCart.h"
#import "OrderPayCell.h"

@implementation OrderPayCell

- (void)awakeFromNib {
    // Initialization code
}

- (OrderPayCell *)initWithProduct:(product *)pro isShoppingCart:(BOOL)isShoppingCart count:(NSInteger)count{
    UINib * nib = [UINib nibWithNibName:@"OrderPayCell" bundle:nil];
    OrderPayCell *cell = [nib instantiateWithOwner:nil options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.labName.text = pro.productName;

    NSMutableArray *proArr = [[ShoppingCart shareShoppingCart] arrayOfShoppingCartWithProductId:pro.productId];
    if (isShoppingCart) {
        cell.labPrice.text = [NSString stringWithFormat:@"%@",[OrderPayCell dealWithPrice:pro.memberPrice count:proArr.count]];
        cell.labCount.text = [NSString stringWithFormat:@"X%lu",proArr.count];
    }else{
        cell.labPrice.text = [NSString stringWithFormat:@"%@",[OrderPayCell dealWithPrice:pro.memberPrice count:count]];
        cell.labCount.text = [NSString stringWithFormat:@"X%lu",count];
    }
    


    if (pro.pics.count > 0) {

        NSString *urlS = imageProduct(pro.vendor, pro.pics[0], @"m");
        [cell.imageName sd_setImageWithURL:[NSURL URLWithString:urlS] placeholderImage:[UIImage imageNamed:@"ugc-photo"]];
    }

    
    return cell;
}
+ (NSString *)dealWithPrice:(NSString *)price count:(NSInteger)count{
    float priceF = [price floatValue];
    float priceYuan = priceF*0.01*count;
    return [NSString stringWithFormat:@"￥%.2f元",priceYuan];
    
}

+(OrderPayCell*)newCellWith:(product *)pro isShoppingCart:(BOOL)isShoppingCart count:(NSInteger)count
{
    
    return [[OrderPayCell alloc]initWithProduct:pro isShoppingCart:isShoppingCart count:count];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
