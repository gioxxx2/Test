//
//  MyPhoneViewController.m
//  BNXComeHere
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 linyj. All rights reserved.
//
#import "UserInfo.h"
#import "MyPhoneViewController.h"

@interface MyPhoneViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    UILabel * lab;
}

@end

@implementation MyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    self.title = @"换绑手机";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
    
    
        [self creatui];
}


/**
 *  界面布局  ＝＝＝   2015－11-3
 *
 */
-(void)creatui
{
    //
    //
    
    //当前绑定手机
    lab = [[UILabel alloc]init];
    lab.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , 64 + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*50);
    NSString * str = [UserInfo shareUserInfo].mobile;
    lab.text = [NSString stringWithFormat:@"当前绑定手机:%@",str];
    lab.font = [UIFont boldSystemFontOfSize:15];
    lab.textColor = RGBA(93,93,93,1);
    lab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab];
    
    
    
    
    
    
    //手机号
    UILabel * lab0 = [[UILabel alloc]init];
    lab0.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , 64 + UI_SCREEN_WIDTH/640*100, UI_SCREEN_WIDTH/640*100, UI_SCREEN_WIDTH/640*50);
    lab0.text = @"手机号";
    lab0.font = [UIFont boldSystemFontOfSize:15];
    lab0.textColor = RGBA(93,93,93,1);
    lab0.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab0];
    
    
//    //请输入需要绑定的手机号
//    UILabel * lab00 = [[UILabel alloc]init];
//    lab00.frame = CGRectMake( lab0.right + UI_SCREEN_WIDTH/640*10 , 64 + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*280, UI_SCREEN_WIDTH/640*50);
//    lab00.text = @"请输入需要绑定的手机号";
//    lab00.font = [UIFont boldSystemFontOfSize:12];
//    lab00.textColor = RGBA(150,150,150,1);
//    lab00.backgroundColor = [UIColor yellowColor];
//    lab00.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:lab00];
    
    
    //请输入需要绑定的手机号
    _phoneNumTf = [[UITextField alloc] initWithFrame:CGRectMake(lab0.right + UI_SCREEN_WIDTH/640*10 , 64 + UI_SCREEN_WIDTH/640*100, UI_SCREEN_WIDTH/640*280, UI_SCREEN_WIDTH/640*50)];
    //    _userTf.leftView = userImgView;
    _phoneNumTf.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumTf.textAlignment = NSTextAlignmentLeft;
    _phoneNumTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneNumTf.keyboardType = UIKeyboardAppearanceDefault;
    _phoneNumTf.placeholder = @"请输入需要绑定的手机号";
    _phoneNumTf.font = [UIFont boldSystemFontOfSize:12];
    _phoneNumTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    _phoneNumTf.delegate = self;
    _phoneNumTf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    //    _phoneNumTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [self.view addSubview:_phoneNumTf];

    
    
    
    //验证码发送触发视图
    UIImageView * bgImgView1111 = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*442,64 + UI_SCREEN_WIDTH/640*104, UI_SCREEN_WIDTH/640*148,UI_SCREEN_WIDTH/640*42)];
    //    bgImgView.image = [UIImage imageNamed:@"头像图标@3x.png"];
    bgImgView1111.backgroundColor = RGBA(34, 156, 232, 1);
    bgImgView1111.userInteractionEnabled = YES;
    [self.view addSubview:bgImgView1111];
    
    checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = CGRectMake(UI_SCREEN_WIDTH/640*444,64 + UI_SCREEN_WIDTH/640*105, UI_SCREEN_WIDTH/640*144,UI_SCREEN_WIDTH/640*40);
    //    checkBtn.tag = 11;
    checkBtn.backgroundColor = [UIColor whiteColor];
    //    [registBtn setTintColor:RGBA(34, 156, 232, 1)];
    //    registBtn.tintColor =RGBA(34, 156, 232, 1);
    [checkBtn setTitleColor:RGBA(34, 156, 232, 1) forState:UIControlStateNormal];
    [checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize: 14];
    //        [registBtn setImage:[UIImage imageNamed:@"注册未选中.png"] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(checkBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    
    
    
    //2条线   第1条
    UIImageView * line1 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, 64 + UI_SCREEN_WIDTH/640*175, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*2)];
    line1.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [self.view addSubview:line1];
    
    
    
    //验证码
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , line1.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*100, UI_SCREEN_WIDTH/640*50);
    lab1.text = @"验证码";
    lab1.font = [UIFont boldSystemFontOfSize:15];
    lab1.textColor = RGBA(93,93,93,1);
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab1];
    
    
//    //请输入手机接收到的验证码
//    UILabel * lab11 = [[UILabel alloc]init];
//    lab11.frame = CGRectMake(lab1.right + UI_SCREEN_WIDTH/640*10 , line1.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*400, UI_SCREEN_WIDTH/640*50);
//    lab11.text = @"请输入手机接收到的验证码";
//    lab11.font = [UIFont boldSystemFontOfSize:12];
//    lab11.textColor = RGBA(150,150,150,1);
//    lab11.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:lab11];
    
    
    //请输入手机接收到的验证码
    _numTf = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right + UI_SCREEN_WIDTH/640*10 , line1.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*400, UI_SCREEN_WIDTH/640*50)];
    //    _userTf.leftView = userImgView;
    _numTf.leftViewMode = UITextFieldViewModeAlways;
    _numTf.textAlignment = NSTextAlignmentLeft;
    _numTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _numTf.keyboardType = UIKeyboardAppearanceDefault;
    _numTf.placeholder = @"请输入手机接收到的验证码";
    _numTf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _numTf.font = [UIFont boldSystemFontOfSize:12];
    _numTf.delegate = self;
    _numTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _numTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [self.view addSubview:_numTf];
    
    
    
    
    //2条线   第2条
    UIImageView * line2 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, line1.bottom + UI_SCREEN_WIDTH/640*100, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*2)];
    line2.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [self.view addSubview:line2];
    
    
    
    
    //确认按钮
    UIButton * surebtn = [[UIButton alloc]init];
    surebtn.frame = CGRectMake( UI_SCREEN_WIDTH/640*120, line2.bottom + UI_SCREEN_WIDTH/640*50, UI_SCREEN_WIDTH/640*400, UI_SCREEN_WIDTH/640*70);
    [surebtn setBackgroundImage:[UIImage imageNamed:@"我的-信息-修改地址-确认修改按钮@3x.png"] forState:UIControlStateNormal];
    
    [surebtn addTarget:self action:@selector(surebtnaction) forControlEvents:UIControlEventTouchUpInside];
    [surebtn setTitle:@"确认绑定" forState: UIControlStateNormal];
    surebtn.titleLabel.font = [UIFont systemFontOfSize: 18];
    //    [surebtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [self.view addSubview:surebtn];
    
    
    
    
    
    
    //
}



#pragma mark -- textField代理 只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    NSLog(@"%@",string);
    return [self validateNumber:string];
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


//获取验证码按钮事件
-(void)checkBtn
{
    

    [self.view endEditing:YES];
    
    NSDictionary *dict = @{@"mobile":_phoneNumTf.text,@"userId":[UserInfo shareUserInfo].userId,@"token":[UserInfo shareUserInfo].token};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    
//    NSString *urlPath = [[NSString alloc] initWithFormat:@"%@member/user/app/mobile/code",demoAddress];
    
    
    [manager POST:editPhoneCodeUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        
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
            
            
            
            SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"验证码发送成功"];
            [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
            }];
            [alertView show];
            

            
            
        }else{
            //登入失败提示消息
            [[ShowHud shareHud] showErrorWithinfo:responseObject[@"errorCode"] controller:self];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
      
    }];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



//确认绑定按钮事件
-(void)surebtnaction
{
    [self.view endEditing:YES];
    
    if ([_phoneNumTf.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"手机号不能为空!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }
  
    else if ([_numTf.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"验证码不能为空!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
        }];
        [alertView show];
        
    }else
    {
        NSDictionary *dict = @{@"mobile":_phoneNumTf.text,@"smsCode":_numTf.text,@"userId":[UserInfo shareUserInfo].userId,@"token":[UserInfo shareUserInfo].token};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

        
        
//        NSString *urlPath = [[NSString alloc] initWithFormat:@"%@member/user/app/mobile/update",demoAddress];
        
        [manager POST:editPhoneUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            

            
            if ([responseObject[@"status"]intValue]==1) {
                
                
                
                SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"换绑手机成功"];
                [alertView addOKButtonWithHandler:^(SIAlertView *alertView) {
                }];
                [alertView show];
                
                
                UserInfo *info = [UserInfo shareUserInfo];
                info.mobile = _phoneNumTf.text;
              
                lab.text = [NSString stringWithFormat:@"当前绑定手机:%@",_phoneNumTf.text];
                
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
