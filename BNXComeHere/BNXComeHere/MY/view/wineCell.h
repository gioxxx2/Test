//
//  wineCell.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/15.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol wineDelegate <NSObject>

- (void)moreWineProductWithProduct:(product *)pro;
- (void)detailWineProductWithProduct:(product *)product;

@end

@interface wineCell : UITableViewCell

@property (nonatomic,retain)NSMutableArray *wineArray;
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic,assign)id <wineDelegate>delegate;
@end
