//
//  WBTextView.m
//  XzWeibo
//
//  Created by 徐智 on 15/11/9.
//  Copyright © 2015年 徐智. All rights reserved.
//

#import "WBTextView.h"

@interface WBTextView ()


@end

@implementation WBTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1.添加提示文字
        self.placeholderLabel = [[UILabel alloc]init];

        self.placeholderLabel.hidden = YES;
        self.placeholderLabel.numberOfLines = 0;
        self.placeholderLabel.backgroundColor = [UIColor clearColor];
        [self insertSubview:self.placeholderLabel atIndex:0];
        
        //2.监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    
    return self;
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
    self.placeholderLabelText = self.placeholderLabelText;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textDidChange{
    self.placeholderLabel.hidden = self.text.length;
}

- (void)setPlaceholderLabelText:(NSString *)placeholderLabelText{
    _placeholderLabelText = [placeholderLabelText copy];
    self.placeholderLabel.text = placeholderLabelText;
    if (placeholderLabelText.length) {
        //有内容就隐藏
        self.placeholderLabel.hidden = NO;
        //计算frame
        CGFloat placeX = 5;
        CGFloat placeY = 7;
        CGFloat maxW = self.frame.size.width - 2*placeX;
        CGFloat maxH = self.frame.size.height - 2*placeY;
        CGSize placeSize = [placeholderLabelText boundingRectWithSize:CGSizeMake(maxW, maxH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size;
        self.placeholderLabel.frame = CGRectMake(placeX, placeY, placeSize.width, placeSize.height);
        
    }else{
        self.placeholderLabel.hidden = YES;
    }
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

@end
