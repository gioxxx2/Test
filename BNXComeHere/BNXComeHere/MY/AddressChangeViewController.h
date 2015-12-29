//
//  AddressChangeViewController.h
//  BNXComeHere
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 linyj. All rights reserved.


//更改地址界面

#import <UIKit/UIKit.h>


@interface AddressChangeViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NavigationBar * _navigation;
    UITextField * _myaddress;
    UITextField * _myname;
//    UITextFieldLabel
    UIImageView * backgroundview;
    
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    UITableView * _TabView;
    
    NSString * ttype;
    
    NSArray *sortedArray;
    NSDictionary *cityDic;
    
    
    NSDictionary *dic;
    UILabel * provincelab;
    UILabel * citylab;
    UILabel * countylab;
    
}

@end
