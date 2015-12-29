//
//  LostPswViewController.h
//  BNXComeHere
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 linyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LostPswViewController : UIViewController<UITextFieldDelegate>
{
    UITextField * _phoneNumTf;
    UITextField * _validationTf;
    NavigationBar * _navigation;
    
    UITextField * _numTf;
    UITextField * _pswTf;
    UIButton * checkBtn;
}


@end
