//
//  GoodsDetailsController.h
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//
#import "product.h"
#import <UIKit/UIKit.h>

@interface GoodsDetailsController : UIViewController
{
    NavigationBar * _navigation;
    int goodsCount;
}
@property(strong, nonatomic) NSString * goods,*old,*now,*exp,*labName,*token,*userid,*productId,*vendor,*memberPrice;
@property(strong, nonatomic) UIImageView * imageV;
@property(strong, nonatomic) NSDictionary * dict;
@property (nonatomic,strong)product *pro;
@end
