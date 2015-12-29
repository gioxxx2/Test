//
//  MembersViewCell.h
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//
#import "product.h"
#import <UIKit/UIKit.h>

@interface MembersViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labName;//商品名

@property (weak, nonatomic) IBOutlet UILabel *labNowPrice;//现价

@property (weak, nonatomic) IBOutlet UILabel *labOldPrice;//原价

@property (weak, nonatomic) IBOutlet UILabel *labBuyCount;//购买数量

@property (weak, nonatomic) IBOutlet UIImageView *imageGood;//图片名


-(void)setCell:(product*)product;
+(MembersViewCell *)newCell;
@end
