//
//  memberView.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/14.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import "memberView.h"

@implementation memberView

+ (instancetype)memberViewWithFrame:(CGRect)frame allMember:(NSString *)allMember myMember:(NSString *)myMember surplus:(NSString *)surplus{
    return [[memberView alloc]initWithFrame:frame allMember:allMember myMember:myMember surplus:surplus];
}

- (instancetype)initWithFrame:(CGRect)frame allMember:(NSString *)allMember myMember:(NSString *)myMember surplus:(NSString *)surplus{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f];
        UIView *topLineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        topLineV.backgroundColor = [UIColor whiteColor];
        [self addSubview:topLineV];
        
        self.allMember = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, self.frame.size.width/3, self.frame.size.height-1)];
        self.allMember.textColor = [UIColor whiteColor];
        self.allMember.textAlignment = NSTextAlignmentCenter;
        self.allMember.font = [UIFont systemFontOfSize:12];
        self.allMember.text = [NSString stringWithFormat:@"总会员数：%@",allMember];
        [self addSubview:self.allMember];
        
        self.myMember = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/3, 1, self.frame.size.width/3, self.frame.size.height-1)];
        self.myMember.textColor = [UIColor whiteColor];
        self.myMember.textAlignment = NSTextAlignmentCenter;
        self.myMember.font = [UIFont systemFontOfSize:12];
        self.myMember.text = [NSString stringWithFormat:@"我的会员数：%@.0",myMember];
        [self addSubview:self.myMember];
        
        self.surplus = [[UILabel alloc]initWithFrame:CGRectMake(2*self.frame.size.width/3, 1, self.frame.size.width/3, self.frame.size.height-1)];
        self.surplus.textColor = [UIColor whiteColor];
        self.surplus.textAlignment = NSTextAlignmentCenter;
        self.surplus.font = [UIFont systemFontOfSize:12];
        self.surplus.text = [NSString stringWithFormat:@"我的余额：￥%@",surplus];
        [self addSubview:self.surplus];
        
    }
    return self;
}
@end
