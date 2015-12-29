//
//  IconCell.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/24.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

+ (IconCell *)iconCell;

@end
