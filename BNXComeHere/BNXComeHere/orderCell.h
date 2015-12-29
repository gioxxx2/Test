//
//  orderCell.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/21.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "productOrder.h"
#import <UIKit/UIKit.h>



@interface orderCell : UITableViewCell
@property (nonatomic,retain)productOrder *proOrder;
@property (nonatomic,assign)CGFloat cellHeight;
+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@end
