//
//  OrderRecordViewCell.m
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//

#import "OrderRecordViewCell.h"
#define GetHeight [UIScreen mainScreen].bounds.size.height //获取屏幕高度
#define GetWidth [UIScreen mainScreen].bounds.size.width  //获取屏幕宽度
@implementation OrderRecordViewCell


-(void)setCell:(NSDictionary*)dic
{
    self.orderNun.text = dic[@"userId"];//订单编号
    self.labName.text = dic[@"productName"];//商品简介
    self.orderData.text = dic[@"createTime"];//订单日期
//    self.labsize.text = dic[@""];//尺码
//    self.labColor.text = dic[@""];//颜色
    self.labCount.text = [NSString stringWithFormat:@"共%@件商品",dic[@"amount"]];//数量
    
    NSString * a1 = dic[@"amount"];
    NSString * a2 = dic[@"costPrice"];
    int intstring = [a1 intValue];
    int intstring2 = [a2 intValue];
    int total = intstring*intstring2;
    
    self.labAllPrice.text = [NSString stringWithFormat:@"¥%d",total];//总价格
    self.labPrice.text = [NSString stringWithFormat:@"¥%@",dic[@"costPrice"]];//单价
//    self.imageGood.image = dic[@""];//图片
}

+(OrderRecordViewCell*)newCell
{
    UINib * nib = [UINib nibWithNibName:@"OrderRecordViewCell" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil][0];
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
