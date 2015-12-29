//
//  MyInformationViewController.h
//  BNXComeHere
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 linyj. All rights reserved.
//


// “个人信息”  界面

#import <UIKit/UIKit.h>

//内联函数要想让子类继承 必须连同实现一起写在interface 的外面
//内联函数（与普通函数不同，内联函数是在编译的时候将函数里的代码复制到函数调用的位置而不是在运行的时候跳到函数的内部执行）
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

@interface MyInformationViewController : UIViewController
{
    NavigationBar * _navigation;
    
    
}
@property(nonatomic,strong)UIImage *image; //保存选择的图片

@property(nonatomic,strong)NSData * picdata1;;

@end
