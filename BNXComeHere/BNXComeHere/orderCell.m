//
//  orderCell.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/21.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "orderProNameL.h"
#import "product.h"
#import "orderCell.h"

@interface orderCell ()
@property (nonatomic,retain)UILabel *orderNoLabel;
@property (nonatomic,retain)UIView *lineV1;
@property (nonatomic,retain)UIView *lineV2;

@property (nonatomic,retain)UILabel *timeLabel;
@property (nonatomic,retain)UILabel *priceLabel;
@property (nonatomic,retain)UILabel *allCountLabel;
@property (nonatomic,retain)NSMutableArray *nameLArr;
@property (nonatomic,retain)NSMutableArray *countLArr;
@end


@implementation orderCell

- (NSMutableArray *)nameLArr{
    if (!_nameLArr) {
        _nameLArr = [NSMutableArray array];
    }
    return _nameLArr;
}

- (NSMutableArray *)countLArr{
    if (!_countLArr) {
        _countLArr = [NSMutableArray array];
    }
    return _countLArr;
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView{
    static NSString *ID = @"orderCell1";
    orderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[orderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
   // orderCell * cell = [[orderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.orderNoLabel = [[UILabel alloc]init];
        self.orderNoLabel.font = [UIFont systemFontOfSize:15.5];
        self.lineV1 = [[UIView alloc]init];
        self.lineV1.backgroundColor = [UIColor grayColor];
        self.lineV2 = [[UIView alloc]init];
        self.lineV2.backgroundColor = [UIColor grayColor];
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.allCountLabel = [[UILabel alloc]init];
        self.allCountLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.textColor = [UIColor redColor];
        self.allCountLabel.text = @"合计:";
//        self.timeLabel.backgroundColor = [UIColor yellowColor];
//        self.orderNoLabel.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:self.orderNoLabel];
        [self.contentView addSubview:self.lineV1];
        [self.contentView addSubview:self.lineV2];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.allCountLabel];
        [self.contentView addSubview:self.priceLabel];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)setProOrder:(productOrder *)proOrder{
    
    
    _proOrder = proOrder;
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单号:%@",proOrder.orderNo];
 
    for (int i = 0; i < proOrder.productArray.count; i++) {
        product *pro = proOrder.productArray[i];
        orderProNameL *nameL = [[orderProNameL alloc]init];
//        nameL.numberOfLines = 2;
        nameL.font = [UIFont systemFontOfSize:16];
        nameL.text = pro.productName;
        [self.contentView addSubview:nameL];
        [self.nameLArr addObject:nameL];
        orderProNameL *countL = [[orderProNameL alloc]init];
        countL.text = [NSString stringWithFormat:@"X %@",pro.buyCount];
        countL.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:countL];
        [self.countLArr addObject:countL];
    }
    self.timeLabel.text = proOrder.createTime;
    self.priceLabel.text = [self dealWithPrice:proOrder.money count:1];
    
    
    self.orderNoLabel.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 30);
    
   
    
    self.lineV1.frame = CGRectMake(CGRectGetMinX(self.orderNoLabel.frame), CGRectGetMaxY(self.orderNoLabel.frame)+5, self.orderNoLabel.frame.size.width, 1);
    
    for (int i = 0; i < self.nameLArr.count; i++) {
        UILabel *nameL = self.nameLArr[i];
        CGFloat Y = 0;
        if (i == 0) {
            Y = CGRectGetMaxY(self.lineV1.frame)+5;
        }else{
            UILabel *nameLa = self.nameLArr[i-1];
            Y = CGRectGetMaxY(nameLa.frame)+5;
        }
        
        product *pro = self.proOrder.productArray[i];
        
        CGSize size = [pro.productName boundingRectWithSize:CGSizeMake(self.lineV1.frame.size.width*0.8, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        nameL.frame = CGRectMake(self.lineV1.frame.origin.x,Y , self.lineV1.frame.size.width*0.8, size.height);
        UILabel *countL = self.countLArr[i];
        countL.textAlignment = NSTextAlignmentRight;
        countL.frame = CGRectMake(CGRectGetMaxX(nameL.frame), nameL.frame.origin.y, self.lineV1.frame.size.width * 0.18 , 30);
        
    }
    UILabel *nameLabel = [self.nameLArr lastObject];
    self.lineV2.frame = CGRectMake(self.lineV1.frame.origin.x, CGRectGetMaxY(nameLabel.frame)+5, self.lineV1.frame.size.width, 1);
    self.timeLabel.frame = CGRectMake(self.lineV1.frame.origin.x, CGRectGetMaxY(self.lineV2.frame)+5, self.lineV2.frame.size.width/2, 20);
    
   CGSize priceSize = [self.priceLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT,20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    self.priceLabel.frame = CGRectMake(self.orderNoLabel.frame.size.width-priceSize.width , self.timeLabel.frame.origin.y, priceSize.width, 20);
    
     self.allCountLabel.frame = CGRectMake(CGRectGetMinX(self.priceLabel.frame)-35 , self.timeLabel.frame.origin.y, 35, 20);
    
    self.cellHeight = CGRectGetMaxY(self.allCountLabel.frame)+10;

    
    [self.nameLArr removeAllObjects];
    
    [self.countLArr removeAllObjects];
    
//    [self layoutSubviews];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
//    self.orderNoLabel.frame = CGRectMake(10, 10, self.contentView.frame.size.width-20, 30);
//    self.lineV1.frame = CGRectMake(CGRectGetMinX(self.orderNoLabel.frame), CGRectGetMaxY(self.orderNoLabel.frame)+5, self.orderNoLabel.frame.size.width, 1);
//    
//    for (int i = 0; i < self.nameLArr.count; i++) {
//        UILabel *nameL = self.nameLArr[i];
//        CGFloat Y = 0;
//        if (i == 0) {
//            Y = CGRectGetMaxY(self.lineV1.frame)+5;
//        }else{
//            UILabel *nameLa = self.nameLArr[i-1];
//            Y = CGRectGetMaxY(nameLa.frame)+5;
//        }
//        
//        product *pro = self.proOrder.productArray[i];
//       
//        CGSize size = [pro.productName boundingRectWithSize:CGSizeMake(self.lineV1.frame.size.width*0.8, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
//        nameL.frame = CGRectMake(self.lineV1.frame.origin.x,Y , self.lineV1.frame.size.width*0.8, size.height);
//        UILabel *countL = self.countLArr[i];
//        countL.frame = CGRectMake(CGRectGetMaxX(nameL.frame), nameL.frame.origin.y, self.lineV1.frame.size.width * 0.2 , 30);
//        
//    }
//    UILabel *nameLabel = [self.nameLArr lastObject];
//    self.lineV2.frame = CGRectMake(self.lineV1.frame.origin.x, CGRectGetMaxY(nameLabel.frame)+5, self.lineV1.frame.size.width, 1);
//    self.timeLabel.frame = CGRectMake(self.lineV1.frame.origin.x, CGRectGetMaxY(self.lineV2.frame)+5, self.lineV2.frame.size.width/2, 20);
//    self.allCountLabel.frame = CGRectMake(self.contentView.frame.size.width*0.6, self.timeLabel.frame.origin.y, 35, 20);
//    self.priceLabel.frame = CGRectMake(CGRectGetMaxX(self.allCountLabel.frame), self.allCountLabel.frame.origin.y, 80, 20);
//    self.cellHeight = CGRectGetMaxY(self.priceLabel.frame);
//    NSLog(@"self.cellheight_________%.f",self.cellHeight);
//   // self.heightBlock(self.cellHeight);
//   
//    [self.nameLArr removeAllObjects];
//   
//    [self.countLArr removeAllObjects];
    
}

- (NSString *)dealWithPrice:(NSString *)price count:(NSInteger)count{
    float priceF = [price floatValue];
    float priceYuan = priceF*0.01*count;
    return [NSString stringWithFormat:@"￥%.2f",priceYuan];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
