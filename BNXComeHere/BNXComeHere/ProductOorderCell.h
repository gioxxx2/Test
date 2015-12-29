//
//  ProductOorderCell.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/22.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "product.h"
#import <UIKit/UIKit.h>

@interface ProductOorderCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic,retain)product *pro;

@end
