//
//  OrderPayView.m
//  BNXTwo
//
//  Created by 陈华军 on 15/10/28.
//  Copyright © 2015年 陈华军. All rights reserved.
//
#import "MyInformationViewController.h"
#import "UserInfo.h"
#import "OrderPayView.h"


@interface OrderPayView ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;



@end

@implementation OrderPayView
//跳转
- (IBAction)btnPushController:(UIButton *)sender {
    if (self.deleagete && [self.deleagete respondsToSelector:@selector(pushInfoVC)]) {
        [self.deleagete pushInfoVC];
    }
}

- (void)setUpWithUserData{
    UserInfo *info = [UserInfo shareUserInfo];
   
    self.labPhone.text = info.mobile;
   
    if (info.province && info.address && info.city && info.county) {
         self.labAddress.text = [NSString stringWithFormat:@"%@%@%@%@",info.province,info.city,info.county,info.address];
       
    }else{
      
        self.labAddress.text = @"请填写详细地址";
    }
    
    if (info.receiveMan) {
   
         self.labName.text = info.receiveMan;
    }else{
      
        self.labName.text = @"请填写收件人";
    }
    
    if ([self.labName.text isEqualToString:@"请填写收件人"] || [self.labAddress.text isEqualToString:@"请填写详细地址"]) {
        self.isInfoDetail = NO;
    }else{
        self.isInfoDetail = YES;
    }
    
//    [self.memoTextView becomeFirstResponder];
    
//    self.memoTextView.alwaysBounceVertical = YES;
    
    //2.监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self.memoTextView];
    
    
    self.aliPayBtn.selected = YES;
    [self btnImageWithState:self.aliPayBtn.selected sender:self.aliPayBtn];
//    self.uuPayBtn.selected = NO;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChange:(NSNotification *)noti{
    UITextField *textF = noti.object;
    self.textLabel.hidden = self.memoTextView.text.length;
    if (self.deleagete && [self.deleagete respondsToSelector:@selector(returnMemmoText:)]) {
        [self.deleagete returnMemmoText:textF.text];
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.memoTextView endEditing:YES];
}

- (IBAction)uuPayAction:(UIButton *)sender {
   [self onlyChooseOnePayTypeWithAnotherState:self.aliPayBtn.selected firstPay:sender secondPay:self.aliPayBtn];
   
}

- (IBAction)aliPayAction:(UIButton *)sender {
    [self onlyChooseOnePayTypeWithAnotherState:self.uuPayBtn.selected firstPay:sender secondPay:self.uuPayBtn];
    
}




#pragma mark -- 只能选择一种支付方式
- (void)onlyChooseOnePayTypeWithAnotherState:(BOOL)state firstPay:(UIButton *)firstPay secondPay:(UIButton *)secondPay{
    if (state) {
        firstPay.selected = !firstPay.selected;
        secondPay.selected = !secondPay.selected;
        [self btnImageWithState:firstPay.selected sender:firstPay];
        [self btnImageWithState:secondPay.selected sender:secondPay];
    }else{
        firstPay.selected = !firstPay.selected;
        [self btnImageWithState:firstPay.selected sender:firstPay];
    }
}


- (void)btnImageWithState:(BOOL)state sender:(id)sender{
    if (state == NO) {
        [sender setBackgroundImage:[UIImage imageNamed:@"订单支付-未选中"] forState:UIControlStateNormal];
    }else{
        
        [sender setBackgroundImage:[UIImage imageNamed:@"订单支付-选中"] forState:UIControlStateNormal];
    }
}







//下拉更多支付方式
- (IBAction)btnActionMore:(UIButton *)sender {
    NSLog(@"其它方式支付");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
