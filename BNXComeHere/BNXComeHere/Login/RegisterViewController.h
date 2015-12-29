//
//  RegisterViewController.h
//  BNXComeHere
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 linyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITextField * _memberNameTf;
    UITextField * _userTf;
    UITextField * _pswTf;
    UITextField * _numTf;
//    UITextField * _emailTf;
//    UITextField * _provinceTf;
//    UITextField * _cityTf;
//    UITextField * _countyTf;
    UITextField * _phoneNumTf;
//    UITextField * _cardNumTf;
//    UIScrollView * _bgScrollView;
//    UITextField * _vipCardNumTf;
//    UITextField * _vipCardPswTf;
//    UITextField * _vipCardPswConfirmTf;
//    UITextField * _addressTf;
    NavigationBar * _navigation;
//    UIView * _bgView;
//    UITableView * _placeTabView;
//    int _isLevel;
//    UITextField * _affirmCardNumTF;
//    UITextField * _posTF;
//    UIView * _tfBgView;
    
//    UITextField * _cardType;        //证件类型
    
    UIButton * checkBtn;
    
}

@end
