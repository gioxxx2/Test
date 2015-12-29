//
//  ShoppViewCell.m
//  BNXComeHere
//
//  Created by 陈华军 on 15/11/19.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "ShoppingCart.h"
#import "ShoppViewCell.h"

@implementation ShoppViewCell

- (ShoppViewCell *)initWithProduct:(product *)pro{
    UINib * nib = [UINib nibWithNibName:@"ShoppViewCell" bundle:nil];
    ShoppViewCell *cell = [nib instantiateWithOwner:nil options:nil][0];
    //调用方法，给单元格赋值
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    cell.goodsTitleLab.text = pro.productName;
   
   
    NSMutableArray *proArr = [[ShoppingCart shareShoppingCart] arrayOfShoppingCartWithProductId:pro.productId];
     cell.priceLab.text = [NSString stringWithFormat:@"%@",[ShoppViewCell dealWithPrice:pro.memberPrice count:proArr.count]];
    
    cell.goodsNumLab.text = [NSString stringWithFormat:@"X%lu",proArr.count];
    cell.numCountLab.text = [NSString stringWithFormat:@"%lu",proArr.count];
       
//    NSString *urlS = [NSString stringWithFormat:demoMiddlegUrl,pro.vendor,pro.pics[0]];
    NSString *urlS = imageProduct(pro.vendor, pro.pics[0], @"m");
    cell.pro = pro;
    [cell.goodsImgV sd_setImageWithURL:[NSURL URLWithString:urlS] placeholderImage:[UIImage imageNamed:@"ugc-photo"]];
    cell.selectState = NO;

    
    return cell;
}
+ (NSString *)dealWithPrice:(NSString *)price count:(NSInteger)count{
    float priceF = [price floatValue];
    float priceYuan = priceF*0.01*count;
    return [NSString stringWithFormat:@"￥%.2f元",priceYuan];
    
}

- (void)setSelectState:(BOOL)selectState{
    _selectState = selectState;
    if (_selectState == YES) {
        _isSelectImg.image = [UIImage imageNamed:@"购物车-选中"];
    }else{
        _isSelectImg.image = [UIImage imageNamed:@"购物车-未选中"];
    }
}

//- (BOOL)selectState{
//    
//    if (_selectState == YES) {
//        _isSelectImg.image = [UIImage imageNamed:@"购物车-选中"];
//    }else{
//        _isSelectImg.image = [UIImage imageNamed:@"购物车-未选中"];
//    }
//    return _selectState;
//}

+(ShoppViewCell *)newCellWithProduct:(product *)pro
{
    
    
    return [[ShoppViewCell alloc]initWithProduct:pro];
}


/**
 *  点击减按钮实现数量的减少
 *
 *  @param sender 减按钮
 */

- (IBAction)deleteBtnAction:(UIButton *)sender {
   int count = [self.numCountLab.text intValue];
    if (count > 1) {
        count--;
        NSMutableArray *dataArr = [[ShoppingCart shareShoppingCart] arrayOfShoppingCartWithProductId:self.pro.productId];
        [dataArr removeObjectAtIndex:count];
        
        
        
        self.countBlock(count);
    }
    self.numCountLab.text = [NSString stringWithFormat:@"%d",count];
    self.goodsNumLab.text = [NSString stringWithFormat:@"X%d",count];
     self.priceLab.text = [NSString stringWithFormat:@"%@",[ShoppViewCell dealWithPrice:self.pro.memberPrice count:count]];
    
}
/**
 *  点击加按钮实现数量的增加
 *
 *  @param sender 加按钮
 */

- (IBAction)addBtnAction:(UIButton *)sender {
    int count = [self.numCountLab.text intValue];
    if (count < [self.pro.amount integerValue]) {
        count++;
        NSMutableArray *dataArr = [[ShoppingCart shareShoppingCart] arrayOfShoppingCartWithProductId:self.pro.productId];
        [dataArr addObject:[self.pro mutableCopy]];
        self.countBlock(count);
    }
    self.numCountLab.text = [NSString stringWithFormat:@"%d",count];
    self.goodsNumLab.text = [NSString stringWithFormat:@"X%d",count];
    self.priceLab.text = [NSString stringWithFormat:@"%@",[ShoppViewCell dealWithPrice:self.pro.memberPrice count:count]];
 
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
