//
//  LoginViewController.m
//  BNXComeHere
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 linyj. All rights reserved.
//

#import "WBTool.h"
#import "UserInfo.h"
#import "LoginViewController.h"
#import "BNXTabBarController.h"
#import "MYViewController.h"
#import "LostPswViewController.h"
#import "RegisterViewController.h"


@interface LoginViewController ()
{
    UIButton *_faceBtn;
    UILabel *_alertLabel;
    UIView *_userInfoBgView;
    UITextField *_userNameTextField;
    UITextField *_passwordTextField;
    BOOL _userInfoIsEditing;
    UITextField *_editingTextField;
    UIView *_otherOptionView;
    UIButton *_loginBtn;
    UIWebView *_loginConnectWebView;
    
    NSString * vipid;
    
    NavigationBar * navigation;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    navigation = [[NavigationBar alloc] init];
    navigation.userInteractionEnabled = YES;
    navigation.titleLabel.text = @"登录";
    [self.view addSubview:navigation];
 
    navigation.hidden = YES;
 
    
    [self creatui];
    


}


/**
 *  新的登陆模式  ＝＝＝   2015－09-28
 *
 */
-(void)creatui
{
    
    UIImageView * bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),UIWIDTH(40)+navigation.bottom,UIWIDTH(20),UIWIDTH(20))];
    bgImgView.image = [UIImage imageNamed:@"头像图标@3x.png"];
    bgImgView.backgroundColor = [UIColor clearColor];
    bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:bgImgView];
    
    //    UIImageView * userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,40,40)];
    //    userImgView.image = [UIImage imageNamed:@"头像图标@3x.png"];
    //    userImgView.backgroundColor = [UIColor clearColor];
    _userTf = [[UITextField alloc] initWithFrame:CGRectMake(UIWIDTH(55),UIWIDTH(30)+navigation.bottom,UI_SCREEN_WIDTH - UIWIDTH(60),UIWIDTH(40))];
    //    _userTf.leftView = userImgView;
    _userTf.leftViewMode = UITextFieldViewModeAlways;
    _userTf.textAlignment = NSTextAlignmentLeft;
    _userTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _userTf.keyboardType = UIKeyboardAppearanceDefault;
    _userTf.placeholder = @"请输入用户名或手机号";
    _userTf.font = [UIFont boldSystemFontOfSize:15];
    _userTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    _userTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [self.view addSubview:_userTf];
    
    UIImageView * lineView = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),_userTf.bottom, UI_SCREEN_WIDTH -UIWIDTH(30),UIWIDTH(1.5))];
    //    lineView.image = [UIImage imageNamed:@"密码图标@3x.png"];
    lineView.backgroundColor = RGBA(34, 156, 232, 1);
    [self.view addSubview:lineView];
    
    
    UIImageView * pswImgView = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),UIWIDTH(90)+navigation.bottom,UIWIDTH(20),UIWIDTH(20))];
    pswImgView.image = [UIImage imageNamed:@"密码图标@3x.png"];
    pswImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pswImgView];
    
    _pswTf = [[UITextField alloc] initWithFrame:CGRectMake(UIWIDTH(55),UIWIDTH(80)+navigation.bottom,UI_SCREEN_WIDTH - UIWIDTH(60),UIWIDTH(40))];
    //    _pswTf.leftView = pswImgView;
    _pswTf.keyboardType = UIKeyboardAppearanceDefault;
//    _pswTf.secureTextEntry = YES;
    _pswTf.leftViewMode = UITextFieldViewModeAlways;
    _pswTf.textAlignment = NSTextAlignmentLeft;
    _pswTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pswTf.placeholder = @"请输入密码";
    _pswTf.font = [UIFont boldSystemFontOfSize:15];
    _pswTf.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    _pswTf.secureTextEntry = YES;
    _pswTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERPsw]?[[NSUserDefaults standardUserDefaults] objectForKey:USERPsw]:nil;
    [self.view addSubview:_pswTf];
    
    
    
    
    
    
    
    UIImageView * lineView1 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(15),_pswTf.bottom, UI_SCREEN_WIDTH -UIWIDTH(30),UIWIDTH(1.5))];
    //    lineView.image = [UIImage imageNamed:@"密码图标@3x.png"];
    lineView1.backgroundColor = RGBA(34, 156, 232, 1);
    [self.view addSubview:lineView1];
    
    
    
    UIButton * forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(UI_SCREEN_WIDTH - UIWIDTH(110),lineView1.bottom+UIWIDTH(20),UIWIDTH(100), UIWIDTH(20));
    forgetBtn.tag = 14;
    forgetBtn.backgroundColor = [UIColor clearColor];
    [forgetBtn setTitleColor:RGBA(101, 120, 147, 1) forState:UIControlStateNormal];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(gotolostvc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    
    
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(UIWIDTH(20),forgetBtn.bottom+UIWIDTH(20),UI_SCREEN_WIDTH - UIWIDTH(40), UIWIDTH(50));
    //    okBtn.tag = 13;
    okBtn.backgroundColor = RGBA(34, 156, 232, 1);
    [okBtn setTintColor:[UIColor whiteColor]];
    [okBtn setTitle:@"登  录" forState:UIControlStateNormal];
    //    [okBtn setImage:[UIImage imageNamed:@"登录选中@3x.png"] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(loginnew) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    
    
    
    UIImageView * bgImgView11 = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(20),okBtn.bottom+UIWIDTH(20),UI_SCREEN_WIDTH - UIWIDTH(40), UIWIDTH(50))];
    //    bgImgView.image = [UIImage imageNamed:@"头像图标@3x.png"];
    bgImgView11.backgroundColor = RGBA(34, 156, 232, 1);
    bgImgView11.userInteractionEnabled = YES;
    [self.view addSubview:bgImgView11];
    
    UIButton * registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(UIWIDTH(21),okBtn.bottom+UIWIDTH(21),UI_SCREEN_WIDTH - UIWIDTH(42), UIWIDTH(48));
    registBtn.tag = 12;
    registBtn.backgroundColor = [UIColor whiteColor];
    [registBtn setTitleColor:RGBA(34, 156, 232, 1) forState:UIControlStateNormal];
    [registBtn setTitle:@"注  册" forState:UIControlStateNormal];
    //    [registBtn setImage:[UIImage imageNamed:@"登录选中@3x.png"] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(gotoregistvc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    
}


-(void)gotolostvc
{
    //
    //
    LostPswViewController *lostvc = [[LostPswViewController alloc]init];
    [self.navigationController pushViewController:lostvc animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)gotoregistvc
{
    //
    //
    RegisterViewController *lostvc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:lostvc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//＊＊＊＊＊＊＊   登录新事件（  2015.10.09   ）
- (void)loginnew
{
    
    [self.view endEditing:YES];
    
    NSDictionary *dict = @{@"account":_userTf.text,@"password":_pswTf.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    
    [manager POST:loginUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if ([responseObject[@"status"]intValue]==1) {
            NSDictionary * responseObjectdic = responseObject;
            NSDictionary * datadic  = [responseObjectdic objectForKey:@"data"];
//            NSLog(@"%@",responseObject);
            [[NSUserDefaults standardUserDefaults] setObject:datadic forKey:UserData];
            
            //存入账号密码 到缓存
            [[NSUserDefaults standardUserDefaults] setObject:_userTf.text forKey:USERName];
            [[NSUserDefaults standardUserDefaults] setObject:_pswTf.text forKey:USERPsw];
            UserInfo *info = [UserInfo shareUserInfo];
            NSDictionary *userDataDic = [[NSUserDefaults standardUserDefaults] objectForKey:UserData];
            [info setValuesForKeysWithDictionary:userDataDic];
            info.UserAcount = [[NSUserDefaults standardUserDefaults] objectForKey:USERName];
            
            
//            SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"登陆成功!"];
//            [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
//             {
//             }];
//            [alertView show];
           
            
//            MYViewController * myvc = [[MYViewController alloc]init];
//            [self.navigationController pushViewController:myvc animated:YES];
//            BNXTabBarController *tabBarVC = [[BNXTabBarController alloc]init];
//            [self.navigationController pushViewController:tabBarVC animated:YES  ];
            [WBTool chooseRootController];
            
        }else{
            if ([_userTf.text isEqualToString:@""] || [_pswTf.text isEqualToString:@""]) {
                //登入失败提示消息
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"缺少用户名或密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                
            }else{
                //登入失败提示消息
                //登入失败提示消息
                [[ShowHud shareHud] showErrorWithinfo:responseObject[@"errorCode"] controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请求失败!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
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
