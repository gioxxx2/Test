//
//  BNXTabBar.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <UIKit/UIKit.h>

//不引入这个类不识别
@class BNXTabBar;
@protocol BNXTabBarDelegate <NSObject>
@optional
//将tabBar里的Button传递出去给控制器
- (void)tabBar:(BNXTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;


@end


@interface BNXTabBar : UIView


- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,weak)id <BNXTabBarDelegate>delegate;

@end
