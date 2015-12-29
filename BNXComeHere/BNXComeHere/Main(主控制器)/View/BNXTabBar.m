//
//  BNXTabBar.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "BNXTabBarButton.h"
#import "BNXTabBar.h"

@interface BNXTabBar ()
@property (nonatomic,strong)NSMutableArray *tabBarButtonArray;
@property (nonatomic,weak)BNXTabBarButton *selectButton;
@end

@implementation BNXTabBar

- (NSMutableArray *)tabBarButtonArray{
    if (!_tabBarButtonArray) {
        _tabBarButtonArray = [NSMutableArray array];
    }
    return _tabBarButtonArray;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(247,247,247,1);
        
    }
    return self;
}


- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    //1.创建按钮
    BNXTabBarButton *button = [BNXTabBarButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    
    //添加按钮到数组中
    [self.tabBarButtonArray addObject:button];
    
    //2.设置数据
    button.item = item;
    
    //3.监听按钮的点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //4.默认选中第0个按钮
    if (self.tabBarButtonArray.count == 2) {
        [self buttonClick:button];
    }
    
    
}


//监听按钮的点击
- (void)buttonClick:(BNXTabBarButton *)button{
    //要现在下面赋值的前面，写在后面的话，就已经赋值了
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectButton.tag-1000 to:button.tag-1000];
    }
    
    
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    //调整加号按钮的位置
   
    
    CGFloat buttonW = self.frame.size.width/self.subviews.count;
    for (int index = 0; index < self.tabBarButtonArray.count; index++) {
        CGFloat buttonX = index * buttonW;
        //取出按钮
        BNXTabBarButton *button = self.tabBarButtonArray[index];
//        if (index > 1) {
//            buttonX += buttonW;
//        }
        //设置frame
        button.frame = CGRectMake(buttonX, 0, self.frame.size.width/self.subviews.count, self.frame.size.height);
        button.tag = index+1000;
    }
    
    
}



@end
