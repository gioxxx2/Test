//
//  MyEmialViewController.m
//  BNXComeHere
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 linyj. All rights reserved.
//
#import "UserInfo.h"
#import "MyEmialViewController.h"

@interface MyEmialViewController ()<UIGestureRecognizerDelegate>

@end

@implementation MyEmialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    self.title = @"绑定邮箱";
  
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
    
    //当前绑定邮箱
    UILabel * lab0 = [[UILabel alloc]init];
    lab0.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , 64 + UI_SCREEN_WIDTH/640*30, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*50);
    if ([UserInfo shareUserInfo].email) {
        lab0.text = [NSString stringWithFormat:@"当前绑定邮箱:%@",[UserInfo shareUserInfo].email];
    }else{
        lab0.text = @"当前暂未绑定邮箱";
    }
    
    lab0.font = [UIFont boldSystemFontOfSize:15];
//    lab0.textColor = RGBA(93,93,93,1);
    lab0.textColor = [UIColor blackColor];
    lab0.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab0];
    
    
    
    
    
    
    //请输入邮箱地址
    _email = [[UITextField alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30 , lab0.bottom + UI_SCREEN_WIDTH/640*50, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*50)];
    //    _userTf.leftView = userImgView;
    _email.leftViewMode = UITextFieldViewModeAlways;
    _email.textAlignment = NSTextAlignmentLeft;
    _email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _email.keyboardType = UIKeyboardAppearanceDefault;
    _email.placeholder = @"请输入邮箱地址";
    _email.font = [UIFont boldSystemFontOfSize:15];
    _email.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _email.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [self.view addSubview:_email];
    
    
    
    //1条线   第1条
    UIImageView * line1 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, _email.bottom + UI_SCREEN_WIDTH/640*2, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*2)];
    line1.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [self.view addSubview:line1];
    
    
    
    
    //确认按钮
    UIButton * surebtn = [[UIButton alloc]init];
    surebtn.frame = CGRectMake( UI_SCREEN_WIDTH/640*120, line1.bottom + UI_SCREEN_WIDTH/640*50, UI_SCREEN_WIDTH/640*400, UI_SCREEN_WIDTH/640*70);
    [surebtn setBackgroundImage:[UIImage imageNamed:@"我的-信息-修改地址-确认修改按钮@3x.png"] forState:UIControlStateNormal];
    
    [surebtn addTarget:self action:@selector(surebtnaction) forControlEvents:UIControlEventTouchUpInside];
    [surebtn setTitle:@"确认绑定" forState: UIControlStateNormal];
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
    //
    //
    [self.view endEditing:YES];
    if ([_email.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"邮箱不能为空!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }else
    {
        NSDictionary *dict = @{@"email":_email.text,@"userId":[UserInfo shareUserInfo].userId,@"token":[UserInfo shareUserInfo].token};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        
        //        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        
//        NSString *urlPath = [[NSString alloc] initWithFormat:@"%@member/user/app/email/update",demoAddress];
        
        [manager POST:editEmailUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
            
            
            if ([responseObject[@"status"]intValue]==1) {
                
                
                //                [[NSUserDefaults standardUserDefaults] setObject:_pswTf.text forKey:USERPsw];
           
                UserInfo *info = [UserInfo shareUserInfo];
                info.email = _email.text;
              
                
                SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"换绑邮箱成功"];
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
