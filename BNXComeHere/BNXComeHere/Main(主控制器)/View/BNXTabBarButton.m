//
//  BNXTabBarButton.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//
//图标比例
#define WBTabBarButtonImageRatio 0.7
#import "BNXTabBarButton.h"

@implementation BNXTabBarButton

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        //        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    highlighted = NO;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * WBTabBarButtonImageRatio);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height * WBTabBarButtonImageRatio-3, contentRect.size.width, contentRect.size.height * (1 -  WBTabBarButtonImageRatio));
}

- (void)setItem:(UITabBarItem *)item{
    _item = item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
}

@end
