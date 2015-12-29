//
//  MenuCollectionCell.m
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/2.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "MenuCollectionCell.h"


@interface MenuCollectionCell()
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UIImageView *imageView;
@end
@implementation MenuCollectionCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}


-(void)setTitleWithString:(NSString *)string image:(UIImage *)image{
    _titleLabel.text = string;
    _imageView.image = image;
}

-(void)initSubviews{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.width-10, self.frame.size.width, 20)];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setTextColor:[UIColor blackColor]];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [self.contentView addSubview:_titleLabel];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-30, self.frame.size.width-30)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.center = CGPointMake(self.frame.size.width/2, (self.frame.size.height-20)/2);
    [self.contentView addSubview:_imageView];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [UIView animateWithDuration: .2 animations:^{
//        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.5, 1.5);
//        self.transform = scaleTransform;
//        self.alpha = 0;
//    } completion:^(BOOL finished) {
//    }];
//}
-(void)touchDown{
    [UIView animateWithDuration: .2 animations:^{
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.5, 1.5);
        self.transform = scaleTransform;
        self.alpha = 0;
    } completion:^(BOOL finished) {
    }];
}

//-(void)drawRect:(CGRect)rect{
//    [_imageView.image drawInRect:CGRectMake(0, 0, self.frame.size.width-40, self.frame.size.width-40)];
//    [_titleLabel.text drawInRect:CGRectMake(0, self.frame.size.width, self.frame.size.width, 20) withAttributes:nil];
//}
@end
