//
//  WBTextView.h
//  XzWeibo
//
//  Created by 徐智 on 15/11/9.
//  Copyright © 2015年 徐智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTextView : UITextView
@property (nonatomic,copy)NSString *placeholderLabelText;
@property (nonatomic,strong)UIColor *placeholderColor;
@property (nonatomic,retain)UILabel *placeholderLabel;
@end
