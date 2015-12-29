//
//  myInfomationVC.m
//  BNXComeHere
//
//  Created by lanou on 15/12/27.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "MyInformationViewController.h"
#import "UserInfo.h"
#import "WXApi.h"
#import "LoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "UIImageView+WebCache.h"
#import "myInfomationVC.h"

@interface myInfomationVC ()
@property (weak, nonatomic) IBOutlet UIImageView *iconV;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *cashabilityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *VipLevelView;
@property (weak, nonatomic) IBOutlet UILabel *VipLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *VipLevelTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *phoneView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addressView;
@property (weak, nonatomic) IBOutlet UILabel *addressTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *MyCountView;
@property (weak, nonatomic) IBOutlet UILabel *myCountTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *myCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *referView;
@property (weak, nonatomic) IBOutlet UILabel *referTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reverLabel;
@property (weak, nonatomic) IBOutlet UIImageView *allCountVIew;
@property (weak, nonatomic) IBOutlet UILabel *allCountTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *allCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *iconEditImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cashView;
@property (weak, nonatomic) IBOutlet UIView *Line;
@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UIView *lineOne;
@property (weak, nonatomic) IBOutlet UIView *lineTwo;

@property (weak, nonatomic) IBOutlet UIView *lineThree;
@property (weak, nonatomic) IBOutlet UIView *linefour;
@property (weak, nonatomic) IBOutlet UIView *linefive;


@end

@implementation myInfomationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"退出图标@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];

     [self SetUpUi];
    
    [self setUpData];
    
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.translucent = NO;
    [[UserInfo shareUserInfo] updateUserInfo];
    [self setUpData];
    NSLog(@"%@ %@",[UserInfo shareUserInfo].iconFilePath,userIconUrl);
//    if ([UserInfo shareUserInfo].iconFilePath ) {
//        self.iconV.image =[UIImage imageWithContentsOfFile:[UserInfo shareUserInfo].iconFilePath];
//        
//    }
    
    
}



-(void)goback
{
    //
    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *loNa = [[UINavigationController alloc]initWithRootViewController:login];
    loNa.navigationBarHidden = YES;
    [self presentViewController:loNa animated:YES completion:nil];
    
}

#pragma mark --  点击“我的头像”按钮
-(void)changepicbtn
{
    
    
    
    
    //跳转到个人信息界面
    MyInformationViewController * myinformationV = [[MyInformationViewController alloc]init];
    
 
    
    [self.navigationController pushViewController:myinformationV animated:YES];
    
    //
}


- (void)setUpData{
    //设置账户名
    self.amountLabel.text = [UserInfo shareUserInfo].account;
    
    [self.iconV sd_setImageWithURL:[NSURL URLWithString:userIconUrl] placeholderImage:[UIImage imageNamed:@"修改头像图标@3x.png"]];
    
    //设置余额
    CGFloat money = [UserInfo shareUserInfo].money;
    self.moneyLabel.text = [NSString stringWithFormat:@"账号余额:%.1f",money];
    
    
    self.VipLevelLabel.text = [UserInfo shareUserInfo].property;
    
    self.phoneLabel.text = [UserInfo shareUserInfo].mobile;
    
    
    UserInfo *info = [UserInfo shareUserInfo];
    if (info.province  && info.city && info.county) {
        self.addressLabel.text = [NSString stringWithFormat:@"%@-%@-%@",info.province,info.city,info.county];
        
    }else{
        
        self.addressLabel.text = @"暂未填写";
    }
    
     self.myCountLabel.text = [NSString stringWithFormat:@"%ld",[UserInfo shareUserInfo].membercount];
    
    
    self.reverLabel.text = [NSString stringWithFormat:@"%ld",[UserInfo shareUserInfo].refercount];
    
    self.allCountLabel.text = [NSString stringWithFormat:@"%ld",[UserInfo shareUserInfo].memberTotal];
    
}


- (void)SetUpUi{
    //设置头像
    self.iconV.layer.cornerRadius = 35;
    self.iconV.clipsToBounds = YES;
    
    
    if (self.iconV.image == nil) {
        self.iconV.image = [UIImage imageNamed:@"修改头像图标@3x.png"];
    }
    self.iconV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changepicbtn)];
    [self.iconV addGestureRecognizer:tap];
    self.iconEditImageView.image = [UIImage imageNamed:@"修改图标3倍"];
    
   
    
   
    
    
    //设置变现
    [self.cashabilityLabel setBackgroundImage:[UIImage imageNamed:@"立即变现按钮@3x.png"] forState:UIControlStateNormal];
    
    [self.cashabilityLabel setTitle:@"立即变现" forState:UIControlStateNormal];
    [self.cashabilityLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cashabilityLabel setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0, 0)];
    self.cashView.image = [UIImage imageNamed:@"立即变现图标@3x.png"];
    self.Line.backgroundColor = RGBA(236,236,236,1);
    
    self.backView.image = [UIImage imageNamed:@"信息背景框@2x.png"];

    
    
    self.VipLevelView.image = [UIImage imageNamed:@"会员级别图标"];
    
    
    
#pragma mark -- 设置电话
    self.phoneView.image = [UIImage imageNamed:@"电话图标@3x"];
    
   
    
    
#pragma mark -- 设置地址
    self.addressView.image = [UIImage imageNamed:@"地址图标@3x.png"];
   
    
#pragma mark -- 设置我的会员
    self.MyCountView.image = [UIImage imageNamed:@"下级会员图标"];
   
    
#pragma mark -- 设置推荐人数
    self.referView.image = [UIImage imageNamed:@"推荐人数图标@3x.png"];
    
    
#pragma mark -- 会员总数
    self.allCountVIew.image = [UIImage imageNamed:@"下级会员图标@3x.png"];
    
    
    [self.shareBtn setTitle:@"分享给好友" forState:UIControlStateNormal];
    self.shareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(sharebtnaction) forControlEvents:UIControlEventTouchUpInside];
   
    [self.shareBtn setBackgroundImage:[UIImage imageNamed:@"分享按钮@3x.png"] forState:UIControlStateNormal];


}




//点击“分享给好友”按钮
-(void)sharebtnaction
{
 
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
    
    //构造分享内容
//    NSDictionary * infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString * appName = @"分享";
    NSString * carPlusURL = userQRCodeUrl;
    NSString * contenStr = @"伴你行，让你赢！欢迎注册登录伴你行会员系统，享受VIP会员特权";
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:contenStr
                                       defaultContent:@"APP内容分享"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:appName
                                                  url:carPlusURL
                                          description:@"APP内容分享"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog( @"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSString * strng = [NSString stringWithFormat:@"%ld",(long)[error errorCode] ];
                                    
                                    if ([strng isEqualToString:@"-22003"]) {
                                        
                                        
                                        
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"微信分享！" message:@"您的手机尚安装微信，安装以后再来分享吧！" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                                        // optional - add more buttons:
                                        [alert addButtonWithTitle:@"Yes"];
                                        [alert show];
                                        
                                    }
                                    
                                    
                                    NSLog(@"TEXT_ShARE_FAI" @"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                                    
                                    NSLog(@"%@",[error errorDescription]);
                                    
                                    
                                    
                                }
                            }];
    
    
    
    
    //
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
