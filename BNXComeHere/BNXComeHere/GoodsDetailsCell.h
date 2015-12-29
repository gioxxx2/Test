//
//  GoodsDetailsCell.h
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//
#import "product.h"
#import <UIKit/UIKit.h>

typedef void (^countBlock)(NSInteger);

@interface GoodsDetailsCell : UITableViewCell
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,retain)product *pro;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labNowPrice;
@property (weak, nonatomic) IBOutlet UILabel *labOldPrice;
@property (weak, nonatomic) IBOutlet UILabel *labLeftCount;
@property (weak, nonatomic) IBOutlet UILabel *labShopName;
@property (weak, nonatomic) IBOutlet UITextField *texCount;
@property (nonatomic,retain) GoodsDetailsCell *gooodCell;

@property (nonatomic,copy)countBlock block;
+(GoodsDetailsCell*)newCellWithProduct:(product *)pro;
@end
