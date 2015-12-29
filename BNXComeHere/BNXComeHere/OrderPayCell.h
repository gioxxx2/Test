//
//  OrderPayCell.h
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//
#import "product.h"
#import <UIKit/UIKit.h>

@interface OrderPayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageName;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labSizeName;
@property (weak, nonatomic) IBOutlet UILabel *labSize;
@property (weak, nonatomic) IBOutlet UILabel *labColorName;
@property (weak, nonatomic) IBOutlet UILabel *labColor;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labCount;

@property (weak, nonatomic) IBOutlet UILabel *labPage;
@property (weak, nonatomic) IBOutlet UIButton *btnLess;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

+(OrderPayCell*)newCellWith:(product *)pro isShoppingCart:(BOOL)isShoppingCart count:(NSInteger)count;

@end
