//
//  orderDetailHeaderView.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/21.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import "orderDetailHeaderView.h"

@interface orderDetailHeaderView ()
@property (nonatomic,retain)UILabel *orderNoLabel;
@property (nonatomic,retain)UIView *lineV;
@property (nonatomic,retain)UIImageView *nameV;
@property (nonatomic,retain)UILabel *nameL;
@property (nonatomic,retain)UIImageView *mobilV;
@property (nonatomic,retain)UILabel *mobilL;
@property (nonatomic,retain)UIImageView *addressV;
@property (nonatomic,retain)UILabel *addressL;
@property (nonatomic,retain)UIView *lineV2;

@end

@implementation orderDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame order:(productOrder *)order{
    if (self = [super initWithFrame:frame]) {
        self.orderNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-20, 30)];
        self.orderNoLabel.text = [NSString stringWithFormat:@"订单号:%@",order.orderNo];
        [self addSubview:self.orderNoLabel];
        self.orderNoLabel.font = [UIFont systemFontOfSize:17];
        self.lineV = [[UIView alloc]initWithFrame:CGRectMake( 0, CGRectGetMaxY(self.orderNoLabel.frame)+5, frame.size.width, 1)];
        self.lineV.backgroundColor = [UIColor grayColor];
        [self addSubview:self.lineV];
        
        self.nameV = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.lineV.frame)+10, 20, 22)];
        self.nameV.image = [UIImage imageNamed:@"订单支付-头像"];
        [self addSubview:self.nameV];
        
        self.nameL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameV.frame)+5, CGRectGetMaxY(self.lineV.frame)+5, 200, 30)];
        self.nameL.text = order.receiveMan;
        [self addSubview:self.nameL];
        
        self.mobilV = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2+10, self.nameV.frame.origin.y, self.nameV.frame.size.width, self.nameV.frame.size.height)];
        self.mobilV.image = [UIImage imageNamed:@"订单支付-手机"];
        [self addSubview:self.mobilV];
        
        self.mobilL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.mobilV.frame)+5, self.nameL.frame.origin.y, 200, 30)];
        self.mobilL.text = order.mobile;
        [self addSubview:self.mobilL];
        
        self.addressV = [[UIImageView alloc]initWithFrame:CGRectMake(self.nameV.frame.origin.x, CGRectGetMaxY(self.nameV.frame)+5, self.nameV.frame.size.width, 26)];
        self.addressL.font = [UIFont systemFontOfSize:15];
        self.addressV.image = [UIImage imageNamed:@"订单支付-定位"];
        [self addSubview:self.addressV];
        
        self.addressL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addressV.frame)+5, CGRectGetMaxY(self.nameL.frame)+5, frame.size.width - (self.nameL.frame.origin.x+10), 30)];
//        self.addressL.backgroundColor = [UIColor yellowColor];
        self.addressL.font = [UIFont systemFontOfSize:16];
        self.addressL.numberOfLines = 0;
        self.addressL.text = [NSString stringWithFormat:@"%@-%@-%@%@",order.province,order.city,order.county,order.address];
        
        CGSize size = [self.addressL.text boundingRectWithSize:CGSizeMake(self.addressL.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        CGRect frame11 = self.addressL.frame;
        frame11.size = size;
        self.addressL.frame = frame11;
        [self addSubview:self.addressL];
        
        self.lineV2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addressL.frame)+10, frame.size.width, 10)];
      
        self.lineV2.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        [self addSubview:self.lineV2];
        
        
    }
    return self;
}

+ (instancetype)initWithFrame:(CGRect)frame order:(productOrder *)order{
    return [[self alloc]initWithFrame:frame order:order];
}


@end
