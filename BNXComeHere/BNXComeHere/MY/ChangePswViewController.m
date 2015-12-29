//
//  ChangePswViewController.m
//  BNXComeHere
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 linyj. All rights reserved.
//
#import "UserInfo.h"
#import "ChangePswViewController.h"

@interface ChangePswViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ChangePswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
    
    
    
    [self creatui];
}


/**
 *  界面布局  ＝＝＝   2015－11-7
 *
 */
-(void)creatui
{
    //
    //


    UILabel * lab0 = [[UILabel alloc]init];
    lab0.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , 64 + UI_SCREEN_WIDTH/640*30, UI_SCREEN_WIDTH/640*140, UI_SCREEN_WIDTH/640*65);
    lab0.text = @"当前密码";
    lab0.font = [UIFont boldSystemFontOfSize:14];
    //    lab0.textColor = RGBA(93,93,93,1);
    lab0.textColor = [UIColor blackColor];
    lab0.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab0];
    
    
    
    _oldpsw = [[UITextField alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*175 + UI_SCREEN_WIDTH/640*5, 64 + UI_SCREEN_WIDTH/640*30, UI_SCREEN_WIDTH/640*435, UI_SCREEN_WIDTH/640*65)];
    //    _userTf.leftView = userImgView;
    _oldpsw.leftViewMode = UITextFieldViewModeAlways;
    _oldpsw.textAlignment = NSTextAlignmentLeft;
    _oldpsw.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _oldpsw.keyboardType = UIKeyboardAppearanceDefault;
    _oldpsw.placeholder = @"请输入当前密码";
    _oldpsw.secureTextEntry = YES;
    _oldpsw.font = [UIFont boldSystemFontOfSize:14];
    _oldpsw.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写

    [self.view addSubview:_oldpsw];
    
    
    //2条线   第1条
    UIImageView * line1 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, _oldpsw.bottom + UI_SCREEN_WIDTH/640*2, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*2)];
    line1.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [self.view addSubview:line1];
    
    
    
    
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , line1.bottom , UI_SCREEN_WIDTH/640*140, UI_SCREEN_WIDTH/640*50);
    lab1.text = @"新密码";
    lab1.font = [UIFont boldSystemFontOfSize:14];
    //    lab0.textColor = RGBA(93,93,93,1);
    lab1.textColor = [UIColor blackColor];
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab1];
    
    _newpsw = [[UITextField alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*175 , line1.bottom , UI_SCREEN_WIDTH/640*405, UI_SCREEN_WIDTH/640*65)];
    //    _userTf.leftView = userImgView;
    _newpsw.secureTextEntry = YES;
    _newpsw.leftViewMode = UITextFieldViewModeAlways;
    _newpsw.textAlignment = NSTextAlignmentLeft;
    _newpsw.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _newpsw.keyboardType = UIKeyboardAppearanceDefault;
    _newpsw.placeholder = @"请输入当前密码";
    _newpsw.font = [UIFont boldSystemFontOfSize:14];
    _newpsw.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    
    [self.view addSubview:_newpsw];
    
    
    //2条线   第2条
    UIImageView * line2 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, _newpsw.bottom + UI_SCREEN_WIDTH/640*2, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*2)];
    line2.backgroundColor = RGBA(236,236,236,1);
    [self.view addSubview:line2];
    
    
    
    
    //确认修改按钮
    UIButton * surebtn = [[UIButton alloc]init];
    surebtn.frame = CGRectMake( UI_SCREEN_WIDTH/640*120, line2.bottom + UI_SCREEN_WIDTH/640*50, UI_SCREEN_WIDTH/640*400, UI_SCREEN_WIDTH/640*70);
    [surebtn setBackgroundImage:[UIImage imageNamed:@"我的-信息-修改地址-确认修改按钮@3x.png"] forState:UIControlStateNormal];
    
    [surebtn addTarget:self action:@selector(surebtnaction) forControlEvents:UIControlEventTouchUpInside];
    [surebtn setTitle:@"确认修改" forState: UIControlStateNormal];
    surebtn.titleLabel.font = [UIFont systemFontOfSize: 18];
    //    [surebtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [self.view addSubview:surebtn];
    
    
    
    
    //
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


//确认绑定按钮事件
-(void)surebtnaction
{
    
    [self.view endEditing:YES];
    if ([_oldpsw.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请输入当前密码!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }else if ([_newpsw.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请输入新密码!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
        }];
        [alertView show];
        
    }else
    {
        NSDictionary *dict = @{@"oldpassword":_oldpsw.text,@"password":_newpsw.text,@"userId":[UserInfo shareUserInfo].userId,@"token":[UserInfo shareUserInfo].token};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
        
//        NSString *urlPath = [[NSString alloc] initWithFormat:@"%@member/user/app/password/update",demoAddress];
        
        [manager POST:editPasswordUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            
            
            if ([responseObject[@"status"]intValue]==1) {
                
             
                
                [[NSUserDefaults standardUserDefaults] setObject:_newpsw.text forKey:USERPsw];
                
                SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"修改密码成功"];
                [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
                }];
                [alertView show];
                
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }else{
                //登入失败提示消息
                [[ShowHud shareHud] showErrorWithinfo:responseObject[@"errorCode"] controller:self];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        
    }
    
    
    
    //
}







-(void)goback
{
    //
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
