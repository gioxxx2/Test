//
//  ScrollView.h
//  恒融汇通
//
//  Created by 陈华军 on 15/7/1.
//  Copyright (c) 2015年 陈华军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollView : UIView
@property(strong, nonatomic) NSArray * arrImageName;//创建存放图片的数组

-(instancetype)initWithFrame:(CGRect)frame;
//重写init方法带图片数组参数的
-(instancetype)initWithFrame:(CGRect)frame andArrImageName:(NSArray *)arrImageName;
@end
