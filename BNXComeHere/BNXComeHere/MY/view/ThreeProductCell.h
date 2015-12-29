//
//  ThreeProductCell.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/15.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "product.h"
#import <UIKit/UIKit.h>


CG_INLINE
CGRect CGRectMake1(CGFloat x, CGFloat y,CGFloat width,CGFloat height){
    //先拿到appDelegate
    
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

@protocol ThreeProductCellDelegate <NSObject>

- (void)moreProductWithProduct:(product *)pro;
- (void)detailProductWithProduct:(product *)product;

@end

@interface ThreeProductCell : UITableViewCell


@property (nonatomic,retain)NSMutableArray *productArray;
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic,assign)id <ThreeProductCellDelegate>delegate;
@end
