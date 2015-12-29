//
//  MembersViewCell.m
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//

#import "MembersViewCell.h"
#import "UIImageView+WebCache.h"
#define GetHeight [UIScreen mainScreen].bounds.size.height //获取屏幕高度
#define GetWidth [UIScreen mainScreen].bounds.size.width  //获取屏幕宽度
@implementation MembersViewCell
-(void)setCell:(product *)product
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.labName.text = product.productName;//商品名字

    self.labOldPrice.text = [NSString stringWithFormat:@"%@",[self dealWithPrice:product.price]];//原价
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    //下划线
    //    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.labOldPrice.text attributes:attribtDic];
    self.labOldPrice.attributedText = attribtStr;
    self.labNowPrice.text = [NSString stringWithFormat:@"%@",[self dealWithPrice:product.memberPrice]];//当前价
    self.labBuyCount.text = [NSString stringWithFormat:@"%@人购买",product.buyCount];//购买人数
    
    //图片展示
    if (product.pics.count > 0) {
//        NSString *urlS = [NSString stringWithFormat:demoMiddlegUrl,product.vendor,product.pics[0]];
        NSString *urlS = imageProduct(product.vendor, product.pics[0], @"m");
        [self.imageGood sd_setImageWithURL:[NSURL URLWithString:urlS] placeholderImage:[UIImage imageNamed:@"ugc-photo"]];
    }else{
        self.imageGood.image = [UIImage imageNamed:@"ugc-photo"];
    }
    

}


- (NSString *)dealWithPrice:(NSString *)price{
    float priceF = [price floatValue];
    float priceYuan = priceF*0.01;
    return [NSString stringWithFormat:@"￥%.2f元",priceYuan];
    
}

+(MembersViewCell *)newCell
{
    UINib * nib = [UINib nibWithNibName:@"MembersViewCell" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil][0];
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
