//
//  ProductOorderCell.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/22.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "ProductOorderCell.h"

@interface ProductOorderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productPicView;
@property (weak, nonatomic) IBOutlet UILabel *productNmaeLabel;
@property (weak, nonatomic) IBOutlet UILabel *productOrderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *productBuyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;

@end

@implementation ProductOorderCell


+ (instancetype)cellWithTabelView:(UITableView *)tableView{
    static NSString *ID = @"orderDetail";
    ProductOorderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [ProductOorderCell newCell];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
     
    }
    
    return cell;
    
}

+(ProductOorderCell *)newCell
{
    UINib * nib = [UINib nibWithNibName:@"ProductOorderCell" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil][0];
}


- (void)setPro:(product *)pro{
    _pro = pro;
    self.productNmaeLabel.text = pro.productName;
    if (pro.pics.count > 0) {
//        NSString *urlS = [NSString stringWithFormat:demoMiddlegUrl,pro.vendor,pro.pics[0]];
        NSString *urlS = imageProduct(pro.vendor, pro.pics[0], @"m");
        [self.productPicView sd_setImageWithURL:[NSURL URLWithString:urlS] placeholderImage:[UIImage imageNamed:@"ugc-photo"]];
    }else{
        self.productPicView.image = [UIImage imageNamed:@"ugc-photo"];
    }
    float price = [pro.price floatValue];
    float price11 = price/100;
    self.productPrice.text = [NSString stringWithFormat:@"￥%.1f",price11];
    self.productBuyCountLabel.text = [NSString stringWithFormat:@"X %@",self.pro.buyCount];
    if ([pro.status isEqualToString:@"01"]) {
        self.productOrderStatusLabel.text = @"待支付";
        self.productOrderStatusLabel.textColor = RGBA(244, 113, 20, 1);
        
    }else if ([pro.status isEqualToString:@"02"]){
        self.productOrderStatusLabel.text = @"待发货";
        self.productOrderStatusLabel.textColor = RGBA(57, 165, 247, 1);
       
    }else if ([pro.status isEqualToString:@"03"]){
        self.productOrderStatusLabel.text = @"配送中";
        self.productOrderStatusLabel.textColor = RGBA(42, 208, 108, 1);
        
    }else if ([pro.status isEqualToString:@"98"]){
        self.productOrderStatusLabel.text = @"订单取消";
        self.productOrderStatusLabel.textColor = RGBA(255, 152, 0, 1);
    }else if ([pro.status isEqualToString:@"99"]){
        self.productOrderStatusLabel.text = @"订单完成";
        self.productOrderStatusLabel.textColor = RGBA(243, 64, 32, 1);
       
    }

}

- (void)setFrame:(CGRect)frame{
    frame.size.height -=5;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
