//
//  RegisterViewController.m
//  BNXComeHere
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 linyj. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.view.backgroundColor = RGBA(230, 230, 230, 1);
    //    NSMutableDictionary * dic = [MenuTableDao getAllCity];
    //    NSLog(@"__%@",dic);
    _navigation = [[NavigationBar alloc] init];
    _navigation.userInteractionEnabled = YES;
    _navigation.titleLabel.text = @"注册";
    [self.view addSubview:_navigation];
    _navigation.hidden = YES;
    
    [self creatui];
    
}



/**
 *  新的注册模式  ＝＝＝   2015－09-29
 *
 */
-(void)creatui
{
    UIImageView * bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),UIWIDTH(40)+_navigation.bottom,UIWIDTH(20),UIWIDTH(20))];
    bgImgView.image = [UIImage imageNamed:@"头像图标@3x.png"];
    bgImgView.backgroundColor = [UIColor clearColor];
    bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:bgImgView];
    
    _userTf = [[UITextField alloc] initWithFrame:CGRectMake(UIWIDTH(55),UIWIDTH(30)+_navigation.bottom,UI_SCREEN_WIDTH - UIWIDTH(60),UIWIDTH(40))];
    //    _userTf.leftView = userImgView;
    _userTf.leftViewMode = UITextFieldViewModeAlways;
    _userTf.textAlignment = NSTextAlignmentLeft;
    _userTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _userTf.keyboardType = UIKeyboardAppearanceDefault;
    _userTf.placeholder = @"用户名大于6位字符";
    _userTf.font = [UIFont boldSystemFontOfSize:15];
    _userTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _userTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [self.view addSubview:_userTf];
    
    UIImageView * lineView = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),_userTf.bottom, UI_SCREEN_WIDTH -UIWIDTH(30),UIWIDTH(1.5))];
    //    lineView.image = [UIImage imageNamed:@"密码图标@3x.png"];
    lineView.backgroundColor = RGBA(34, 156, 232, 1);
    [self.view addSubview:lineView];
    
    
    
    
    
    UIImageView * phoneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),UIWIDTH(20)+lineView.bottom,UIWIDTH(20),UIWIDTH(20))];
    phoneImgView.image = [UIImage imageNamed:@"手机图标@3x.png"];
    phoneImgView.backgroundColor = [UIColor clearColor];
    phoneImgView.userInteractionEnabled = YES;
    [self.view addSubview:phoneImgView];
    
    _phoneNumTf = [[UITextField alloc] initWithFrame:CGRectMake(UIWIDTH(55),UIWIDTH(10)+lineView.bottom,UI_SCREEN_WIDTH - UIWIDTH(60),UIWIDTH(40))];
    //    _userTf.leftView = userImgView;
    _phoneNumTf.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumTf.textAlignment = NSTextAlignmentLeft;
    _phoneNumTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneNumTf.keyboardType = UIKeyboardAppearanceDefault;
    _phoneNumTf.placeholder = @"请输入手机号";
    _phoneNumTf.font = [UIFont boldSystemFontOfSize:15];
    _phoneNumTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _phoneNumTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [self.view addSubview:_phoneNumTf];
    
    UIImageView * lineView1 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),_phoneNumTf.bottom, UI_SCREEN_WIDTH -UIWIDTH(30),UIWIDTH(1.5))];
    //    lineView.image = [UIImage imageNamed:@"密码图标@3x.png"];
    lineView1.backgroundColor = RGBA(34, 156, 232, 1);
    [self.view addSubview:lineView1];
    
    
    
    
    //验证码发送触发视图
    UIImageView * bgImgView1111 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(213),UIWIDTH(8)+lineView.bottom, UIWIDTH(92),UIWIDTH(34))];
    //    bgImgView.image = [UIImage imageNamed:@"头像图标@3x.png"];
    bgImgView1111.backgroundColor = RGBA(34, 156, 232, 1);
    bgImgView1111.userInteractionEnabled = YES;
    [self.view addSubview:bgImgView1111];
    
    checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = CGRectMake(UIWIDTH(214),UIWIDTH(9)+lineView.bottom, UIWIDTH(90),UIWIDTH(32));
    //    checkBtn.tag = 11;
    checkBtn.backgroundColor = [UIColor whiteColor];
    //    [registBtn setTintColor:RGBA(34, 156, 232, 1)];
    //    registBtn.tintColor =RGBA(34, 156, 232, 1);
    [checkBtn setTitleColor:RGBA(34, 156, 232, 1) forState:UIControlStateNormal];
    [checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    //        [registBtn setImage:[UIImage imageNamed:@"注册未选中.png"] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(checkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    
    
    
    
    
    
    
    
    UIImageView * phoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),UIWIDTH(20)+lineView1.bottom,UIWIDTH(20),UIWIDTH(20))];
    phoImgView.image = [UIImage imageNamed:@"已选择按钮.png"];
    phoImgView.backgroundColor = [UIColor clearColor];
    phoImgView.userInteractionEnabled = YES;
    [self.view addSubview:phoImgView];
    
    _numTf = [[UITextField alloc] initWithFrame:CGRectMake(UIWIDTH(55),UIWIDTH(10)+lineView1.bottom,UI_SCREEN_WIDTH - UIWIDTH(60),UIWIDTH(40))];
    //    _userTf.leftView = userImgView;
    _numTf.leftViewMode = UITextFieldViewModeAlways;
    _numTf.textAlignment = NSTextAlignmentLeft;
    _numTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _numTf.keyboardType = UIKeyboardAppearanceDefault;
    _numTf.placeholder = @"请输入短信验证码";
    _numTf.font = [UIFont boldSystemFontOfSize:15];
    _numTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _numTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [self.view addSubview:_numTf];
    
    UIImageView * lineView2 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),_numTf.bottom, UI_SCREEN_WIDTH -UIWIDTH(30),UIWIDTH(1.5))];
    //    lineView.image = [UIImage imageNamed:@"密码图标@3x.png"];
    lineView2.backgroundColor = RGBA(34, 156, 232, 1);
    [self.view addSubview:lineView2];
    
    
    
    
    
    UIImageView * pswImgView = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),UIWIDTH(20)+lineView2.bottom,UIWIDTH(20),UIWIDTH(20))];
    pswImgView.image = [UIImage imageNamed:@"密码图标@3x.png"];
    pswImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pswImgView];
    
    _pswTf = [[UITextField alloc] initWithFrame:CGRectMake(UIWIDTH(55),UIWIDTH(10)+lineView2.bottom,UIWIDTH(263) - UIWIDTH(55),UIWIDTH(40))];
    //    _pswTf.leftView = pswImgView;
    _pswTf.keyboardType = UIKeyboardAppearanceDefault;
//    _pswTf.secureTextEntry = YES;
    _pswTf.leftViewMode = UITextFieldViewModeAlways;
    _pswTf.textAlignment = NSTextAlignmentLeft;
    _pswTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pswTf.placeholder = @"请设置6～12位密码";
    _pswTf.font = [UIFont boldSystemFontOfSize:15];
    _pswTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _pswTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERPsw]?[[NSUserDefaults standardUserDefaults] objectForKey:USERPsw]:nil;
    _pswTf.secureTextEntry = YES;
    [self.view addSubview:_pswTf];
    
    
    
    
    UIImageView * bgImgView001 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(263),UIWIDTH(19)+lineView2.bottom,UIWIDTH(42),UIWIDTH(22))];
    bgImgView001.image = [UIImage imageNamed:@"密码可见图标.png"];
    bgImgView001.backgroundColor = [UIColor clearColor];
    bgImgView001.userInteractionEnabled = YES;
    [self.view addSubview:bgImgView001];
    
    
    
    UIImageView * lineView3 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),_pswTf.bottom, UI_SCREEN_WIDTH -UIWIDTH(30),UIWIDTH(1.5))];
    //    lineView.image = [UIImage imageNamed:@"密码图标@3x.png"];
    lineView3.backgroundColor = RGBA(34, 156, 232, 1);
    [self.view addSubview:lineView3];
    
    
    
    //    UIButton * forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    forgetBtn.frame = CGRectMake(UI_SCREEN_WIDTH - UIWIDTH(110),lineView3.bottom+UIWIDTH(20),UIWIDTH(100), UIWIDTH(20));
    //    forgetBtn.tag = 14;
    //    forgetBtn.backgroundColor = [UIColor clearColor];
    //    [forgetBtn setTitleColor:RGBA(101, 120, 147, 1) forState:UIControlStateNormal];
    //    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    //    [forgetBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:forgetBtn];
    
    
    
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(UIWIDTH(20),lineView3.bottom+UIWIDTH(40),UI_SCREEN_WIDTH - UIWIDTH(40), UIWIDTH(50));
    //    okBtn.tag = 13;
    okBtn.backgroundColor = RGBA(34, 156, 232, 1);
    [okBtn setTintColor:[UIColor whiteColor]];
    [okBtn setTitle:@"注  册" forState:UIControlStateNormal];
    //    [okBtn setImage:[UIImage imageNamed:@"登录选中@3x.png"] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(gogogo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    
    
    
    UIImageView * bgImgView11 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(20),okBtn.bottom+UIWIDTH(20),UI_SCREEN_WIDTH - UIWIDTH(40), UIWIDTH(50))];
    //    bgImgView.image = [UIImage imageNamed:@"头像图标@3x.png"];
    bgImgView11.backgroundColor = RGBA(34, 156, 232, 1);
    bgImgView11.userInteractionEnabled = YES;
    [self.view addSubview:bgImgView11];
    
    UIButton * registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(UIWIDTH(21),okBtn.bottom+UIWIDTH(21),UI_SCREEN_WIDTH - UIWIDTH(42), UIWIDTH(48));
    //    registBtn.tag = 11;
    registBtn.backgroundColor = [UIColor whiteColor];
    //    [registBtn setTintColor:RGBA(34, 156, 232, 1)];
    //    registBtn.tintColor =RGBA(34, 156, 232, 1);
    [registBtn setTitleColor:RGBA(34, 156, 232, 1) forState:UIControlStateNormal];
    [registBtn setTitle:@"登  录" forState:UIControlStateNormal];
    //        [registBtn setImage:[UIImage imageNamed:@"注册未选中.png"] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}



-(void)goback
{
    //
    //
    [self.navigationController popViewControllerAnimated:YES];
    

    
    
}


//＊＊＊＊＊＊＊   发送验证码按钮事件
- (void)checkBtn:(id)sender
{
    //
    //
    //
    
    NSDictionary *dict = @{@"mobile":_phoneNumTf.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-www-form-urlencoded"];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //    [manager POST:@"http://121.43.159.163:8080/member/user/app/register/sms/code?" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        <#code#>
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        <#code#>
    //    }];
  
    [manager GET:registCodeUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"111111%@",responseObject);
      
        
        
        if ([responseObject[@"status"]intValue]==1) {
            

            
            
            __block int timeout=120; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    //                    dispatch_release(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮或Label显示 根据自己需求设置
                        //.............
                        [checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    });
                }else{
                    int minutes = timeout / 60;
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%d分%.2d秒",minutes, seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮或Label显示 根据自己需求设置
                        //................
                        [checkBtn setTitle:strTime forState:UIControlStateNormal];
                    });
                    timeout--;
                    
                }
            });
            dispatch_resume(_timer);
            
            
            
            
            //            //存入账号密码 到缓存
            //            _UserDef = [NSUserDefaults standardUserDefaults];
            //            [_UserDef setObject:_txtName.text forKey:@"loginName"];
            //            [_UserDef setObject:_txtPWD.text forKey:@"pwd"];
            //            [_UserDef synchronize];
            //            NSLog(@"%@",NSHomeDirectory());
            
            
            NSLog(@"1111111 验证码发送成功  111111111");
            
            
        }else{
            //登入失败提示消息
            [[ShowHud shareHud] showErrorWithinfo:responseObject[@"errorCode"] controller:self];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"1111111111111111%@",error);
    }];
    
    
    
}


//＊＊＊＊＊＊＊   注册按钮事件
- (void)gogogo
{
    //
    
    
    //
    //
    if ([_userTf.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"账号不能为空!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }
    else if ([_phoneNumTf.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"手机号不能为空!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
        }];
        [alertView show];
        
    }
    else if ([_numTf.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"验证码不能为空!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
        }];
        [alertView show];
        
    }
    else if (_pswTf.text.length<6)
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"密码不能低于6位!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
        }];
        [alertView show];
        
    }else
    {
        
        
        NSDictionary *dict = @{@"account":_userTf.text,@"mobile":_phoneNumTf.text,@"smsCode":_numTf.text,@"password":_pswTf.text};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

        
        
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    

        [manager POST:registUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
            if ([responseObject[@"status"]intValue]==1) {
                
                
                SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"注册成功"];
                [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
                }];
                [alertView show];
                

                
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }else{
                //登入失败提示消息
                //登入失败提示消息
                [[ShowHud shareHud] showErrorWithinfo:responseObject[@"errorCode"] controller:self];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        }];
        
        
    }
    
    
    
    
    
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
