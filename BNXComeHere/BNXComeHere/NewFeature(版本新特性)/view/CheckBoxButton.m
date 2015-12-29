//
//  CheckBoxButton.m
//  XzWeibo
//
//  Created by 徐智 on 15/11/3.
//  Copyright © 2015年 徐智. All rights reserved.
//

#import "CheckBoxButton.h"

@implementation CheckBoxButton

+ (instancetype)checkButton{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        [self setTitle:@"分享给大家" forState:UIControlStateNormal];
        self.selected = YES;
        [self setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

@end
