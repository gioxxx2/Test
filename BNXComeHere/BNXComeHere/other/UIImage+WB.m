//
//  UIImage+WB.m
//  XzWeibo
//
//  Created by 徐智 on 15/11/2.
//  Copyright © 2015年 徐智. All rights reserved.
//

#import "UIImage+WB.h"

@implementation UIImage (WB)


+ (UIImage *)resizedImageWithName:(NSString *)name{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

@end
