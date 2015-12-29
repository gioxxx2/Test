//
//  ProductHomeVC.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <UIKit/UIKit.h>

CG_INLINE
CGRect CGRectMake12(CGFloat x, CGFloat y,CGFloat width,CGFloat height){
    //先拿到appDelegate
    
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

@interface ProductHomeVC : UIViewController
@property (strong,nonatomic)NSDictionary *dataDic;//
@end
