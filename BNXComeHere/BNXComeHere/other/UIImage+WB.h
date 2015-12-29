//
//  UIImage+WB.h
//  XzWeibo
//
//  Created by 徐智 on 15/11/2.
//  Copyright © 2015年 徐智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WB)

+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end
