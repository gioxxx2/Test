//
//  GoodsDetailsCell.m
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//
#import "ShoppingCart.h"
#import "GoodsDetailsCell.h"

@interface GoodsDetailsCell ()
@property (weak, nonatomic) IBOutlet UILabel *expressLabel;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,assign)NSInteger buyCount;

@end

@implementation GoodsDetailsCell

- (void)awakeFromNib {
    // Initialization code
}


- (GoodsDetailsCell *)initWithPro:(product *)pro{
    UINib * nib = [UINib nibWithNibName:@"GoodsDetailsCell" bundle:nil];
    GoodsDetailsCell *cell = [nib instantiateWithOwner:nil options:nil][0];
    
    cell.labName.text = pro.desc;
    cell.labNowPrice.text = [NSString stringWithFormat:@"%@",[GoodsDetailsCell dealWithPrice:pro.memberPrice]];
    cell.labOldPrice.text = [NSString stringWithFormat:@"%@",[GoodsDetailsCell dealWithPrice:pro.price]];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:cell.labOldPrice.text attributes:attribtDic];
    cell.labOldPrice.attributedText = attribtStr;
    cell.labLeftCount.text = [NSString stringWithFormat:@"(库存%@件)",pro.amount];
    cell.expressLabel.text = [NSString stringWithFormat:@"运费%@",[GoodsDetailsCell dealWithPrice:pro.express]];
    cell.labShopName.text = pro.productName;
    cell.pro = pro;
    CGSize size = [pro.desc boundingRectWithSize:CGSizeMake(cell.labName.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    cell.cellHeight = size.height + cell.labName.frame.origin.y;
    if (pro.amount > 0) {
        cell.texCount.text = @"1";
    }else{
        cell.texCount.text = @"0";
    }
    cell.texCount.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}



+(GoodsDetailsCell*)newCellWithProduct:(product *)pro
{
   
    return [[GoodsDetailsCell alloc]initWithPro:pro];
}

+ (NSString *)dealWithPrice:(NSString *)price{
    float priceF = [price floatValue];
    float priceYuan = priceF*0.01;
    return [NSString stringWithFormat:@"￥%.1f元",priceYuan];
    
}

//加个数 123
- (IBAction)btnAddCount:(UIButton *)sender {
    
    int  count=[self.texCount.text  intValue];
    if (count < [self.pro.amount integerValue]) {
        count++;
        self.block(count);
    }
    self.texCount.text=[NSString  stringWithFormat:@"%d",count];
    
}
//减个数 122
- (IBAction)btnSubCount:(UIButton *)sender {
    
    int  count=[self.texCount.text  intValue];
    if (count>0)
    {
        count--;
        self.block(count);
    }
    self.texCount.text=[NSString  stringWithFormat:@"%d",count];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
