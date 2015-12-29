//
//  LostPswViewController.m
//  BNXComeHere
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 linyj. All rights reserved.
//

#import "LostPswViewController.h"

@interface LostPswViewController ()

@end

@implementation LostPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _navigation = [[NavigationBar alloc] init];
    _navigation.userInteractionEnabled = YES;
    //    navigation.titleLabel.text = @"获取验证码";
    _navigation.titleLabel.text = @"找回密码";
    _navigation.leftButton.tag = 11;
    [_navigation.leftButton setImage:[UIImage imageNamed:@"返回按钮.png"] forState:UIControlStateNormal];
//    [_navigation.leftButton setImage:[UIImage imageNamed:@"dismiss_h"] forState:UIControlStateHighlighted];
    [_navigation.leftButton addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navigation];
    
    
    
    [self creatui];
    
    
    
}


/**
 *  新的登陆模式  ＝＝＝   2015－10-08
 *
 */
-(void)creatui
{
    //
    //
    
    UIImageView * bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,_navigation.bottom,UIWIDTH(320),UI_SCREEN_HEIGHT-_navigation.bottom)];
    //    bgImgView.image = [UIImage imageNamed:@"头像图标@3x.png"];
    bgImgView.backgroundColor = [UIColor whiteColor];
    bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:bgImgView];
    
    
    
    UILabel * pholab = [[UILabel alloc]initWithFrame:CGRectMake(UIWIDTH(15), 0, UIWIDTH(60), UIWIDTH(50))];
    pholab.text = @"手机号";
    pholab.backgroundColor = [UIColor clearColor];
    //    [pholab setFont:[UIFont systemFontOfSize:15]];
    [bgImgView addSubview:pholab];
    
    _phoneNumTf = [[UITextField alloc] initWithFrame:CGRectMake(UIWIDTH(75),0,UI_SCREEN_WIDTH - UIWIDTH(90),UIWIDTH(50))];
    //    _userTf.leftView = userImgView;
    _phoneNumTf.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumTf.textAlignment = NSTextAlignmentLeft;
    _phoneNumTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneNumTf.keyboardType = UIKeyboardAppearanceDefault;
    _phoneNumTf.placeholder = @"请输入手机号";
    _phoneNumTf.font = [UIFont boldSystemFontOfSize:15];
    _phoneNumTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _phoneNumTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [bgImgView addSubview:_phoneNumTf];
    
    
    UIImageView * lineView = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),_phoneNumTf.bottom+UIWIDTH(1), UI_SCREEN_WIDTH -UIWIDTH(30),UIWIDTH(1.5))];
    lineView.backgroundColor = RGBA(214, 214, 214, 1);
    [bgImgView addSubview:lineView];
    
    
    
    
    //验证码发送触发视图
    UIImageView * bgImgView1111 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(213),UIWIDTH(9), UIWIDTH(92),UIWIDTH(32))];
    //    bgImgView.image = [UIImage imageNamed:@"头像图标@3x.png"];
    bgImgView1111.backgroundColor = RGBA(34, 156, 232, 1);
    bgImgView1111.userInteractionEnabled = YES;
    [bgImgView addSubview:bgImgView1111];
    
    checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = CGRectMake(UIWIDTH(214),UIWIDTH(10), UIWIDTH(90),UIWIDTH(30));
    //    checkBtn.tag = 11;
    checkBtn.backgroundColor = [UIColor whiteColor];
    //    [registBtn setTintColor:RGBA(34, 156, 232, 1)];
    //    registBtn.tintColor =RGBA(34, 156, 232, 1);
    [checkBtn setTitleColor:RGBA(34, 156, 232, 1) forState:UIControlStateNormal];
    [checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    //        [registBtn setImage:[UIImage imageNamed:@"注册未选中.png"] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(checkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:checkBtn];
    
    
    
    
    
    
    
    
    UILabel * numTflab = [[UILabel alloc]initWithFrame:CGRectMake(UIWIDTH(15), lineView.bottom, UIWIDTH(60), UIWIDTH(50))];
    numTflab.text = @"验证码";
    numTflab.backgroundColor = [UIColor clearColor];
    [bgImgView addSubview:numTflab];
    
    _numTf = [[UITextField alloc] initWithFrame:CGRectMake(UIWIDTH(75),lineView.bottom,UI_SCREEN_WIDTH - UIWIDTH(90),UIWIDTH(50))];
    //    _userTf.leftView = userImgView;
    _numTf.leftViewMode = UITextFieldViewModeAlways;
    _numTf.textAlignment = NSTextAlignmentLeft;
    _numTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _numTf.keyboardType = UIKeyboardAppearanceDefault;
    _numTf.placeholder = @"请输入短信验证码";
    _numTf.font = [UIFont boldSystemFontOfSize:15];
    _numTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _phoneNumTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [bgImgView addSubview:_numTf];
    
    
    UIImageView * lineView1 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),_numTf.bottom+UIWIDTH(1), UI_SCREEN_WIDTH -UIWIDTH(30),UIWIDTH(1.5))];
    lineView1.backgroundColor = RGBA(214, 214, 214, 1);
    [bgImgView addSubview:lineView1];
    
    
    
    
    
    
    
    
    
    UILabel * pswlab = [[UILabel alloc]initWithFrame:CGRectMake(UIWIDTH(15), lineView1.bottom, UIWIDTH(60), UIWIDTH(50))];
    pswlab.text = @"新密码";
    pswlab.backgroundColor = [UIColor clearColor];
    [bgImgView addSubview:pswlab];
    
    _pswTf = [[UITextField alloc] initWithFrame:CGRectMake(UIWIDTH(75),lineView1.bottom,UI_SCREEN_WIDTH - UIWIDTH(90),UIWIDTH(50))];
    //    _userTf.leftView = userImgView;
    _pswTf.leftViewMode = UITextFieldViewModeAlways;
    _pswTf.textAlignment = NSTextAlignmentLeft;
    _pswTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pswTf.keyboardType = UIKeyboardAppearanceDefault;
    _pswTf.placeholder = @"请设置6-12位密码";
    _pswTf.font = [UIFont boldSystemFontOfSize:15];
    _pswTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _phoneNumTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    _pswTf.secureTextEntry = YES;
    [bgImgView addSubview:_pswTf];
    
    
    
    UIImageView * bgImgView001 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(263),UIWIDTH(14)+lineView1.bottom,UIWIDTH(42),UIWIDTH(22))];
    bgImgView001.image = [UIImage imageNamed:@"密码可见图标.png"];
    bgImgView001.backgroundColor = [UIColor clearColor];
    bgImgView001.userInteractionEnabled = YES;
    [bgImgView addSubview:bgImgView001];
    
    
    
    UIImageView * lineView2 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),_pswTf.bottom+UIWIDTH(1), UI_SCREEN_WIDTH -UIWIDTH(30),UIWIDTH(1.5))];
    lineView2.backgroundColor = RGBA(214, 214, 214, 1);
    [bgImgView addSubview:lineView2];
    
    
    
    
    
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(UIWIDTH(60),_pswTf.bottom+UIWIDTH(30),UIWIDTH(200), UIWIDTH(35));
    //    okBtn.tag = 13;
    okBtn.backgroundColor = RGBA(34, 156, 232, 1);
    [okBtn setTintColor:[UIColor whiteColor]];
    [okBtn setTitle:@"确  定" forState:UIControlStateNormal];
    //    [okBtn setImage:[UIImage imageNamed:@"登录选中@3x.png"] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:okBtn];
    
    
    
    
    
}

-(void)goback
{
    //
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)sure
{
    NSLog(@"＊＊＊＊＊＊＊＊＊＊确定按钮点击事件已点击");
    
    if ([_phoneNumTf.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"手机号不能为空!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }
    else if ([_pswTf.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"密码不能为空!"];
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
        NSDictionary *dict = @{@"mobile":_phoneNumTf.text,@"smsCode":_numTf.text,@"password":_pswTf.text};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-www-form-urlencoded"];
        //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        //    [manager POST:@"http://121.43.159.163:8080/member/user/app/register/sms/code?" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        <#code#>
        //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        <#code#>
        //    }];
        
        
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
        
        [manager POST:forgetPasswordUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"111111%@",responseObject);
            //        NSLog(@"111111%@",responseObject);
            //        NSLog(@"111111%@",responseObject);
            //        NSLog(@"111111%@",responseObject);
            //        NSLog(@"111111%@",responseObject);
            //        NSLog(@"111111%@",responseObject);
            
            
            if ([responseObject[@"status"]intValue]==1) {
                
       
//                [[NSUserDefaults standardUserDefaults] setObject:_pswTf.text forKey:USERPsw];
                
                NSLog(@"1111111 发送成功  111111111");
                
                SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"密码更改成功"];
                [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
                }];
                [alertView show];
                
                [[NSUserDefaults standardUserDefaults] setObject:_pswTf.text forKey:USERPsw];
                
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }else{
                //登入失败提示消息
                [[ShowHud shareHud] showErrorWithinfo:responseObject[@"errorCode"] controller:self];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"1111111111111111%@",error);
        }];

        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//＊＊＊＊＊＊＊   发送验证码按钮事件
- (void)checkBtn:(id)sender
{
    //
    //
    //
    
    NSDictionary *dict = @{@"mobile":_phoneNumTf.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
  
    
    [manager GET:forgetPasswordCodeUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

            

            SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"发送成功"];
            [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
            }];
            [alertView show];
            
            NSLog(@"1111111 验证码发送成功  111111111");
            
            
        }else{
            //登入失败提示消息
            [[ShowHud shareHud] showErrorWithinfo:responseObject[@"errorCode"] controller:self];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"1111111111111111%@",error);
    }];
    
    
    
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
