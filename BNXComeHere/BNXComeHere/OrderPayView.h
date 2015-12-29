//
//  OrderPayView.h
//  BNXTwo
//
//  Created by 陈华军 on 15/10/28.
//  Copyright © 2015年 陈华军. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,payType) {
    AliPay,
    UUPay
};

@protocol orderPayDeleate <NSObject>

- (void)pushInfoVC;

- (void)returnMemmoText:(NSString *)text;

@end



@interface OrderPayView : UIView
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UIButton *aliPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *uuPayBtn;
@property (nonatomic,assign)BOOL isInfoDetail;
@property (nonatomic,assign) id<orderPayDeleate>deleagete;

@property(assign, nonatomic) BOOL isSelected;

- (void)setUpWithUserData;

@end
