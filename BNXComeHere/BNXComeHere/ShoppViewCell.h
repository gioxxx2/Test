//
//  ShoppViewCell.h
//  BNXComeHere
//
//  Created by 陈华军 on 15/11/19.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "product.h"
#import <UIKit/UIKit.h>
#import "GoodsInfoModel.h"

typedef void (^block)(NSInteger);

@interface ShoppViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgV;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLab;
@property (weak, nonatomic) IBOutlet UILabel *numCountLab;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UIImageView *isSelectImg;

@property(assign,nonatomic)BOOL selectState;//选中状态
@property (nonatomic,retain)product *pro;
@property (nonatomic,copy)block countBlock;
+(ShoppViewCell *)newCellWithProduct:(product *)pro;


@end
