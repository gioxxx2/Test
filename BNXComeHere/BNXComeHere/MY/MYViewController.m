//
//  MYViewController.m
//  BNXComeHere
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 linyj. All rights reserved.
//
#import "UserInfo.h"
#import "BNXNavigationController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "LoginViewController.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MYViewController.h"
#import "MyInformationViewController.h"
#import "MenuCollectionCell.h"


//导航栏标题的字体大小
#define NAV_Font 18
#define NavHeight 44
#define GetHeight [UIScreen mainScreen].bounds.size.height //获取屏幕高度
#define GetWidth [UIScreen mainScreen].bounds.size.width  //获取屏幕宽度
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//导航栏的背景颜色
#define NAV_Color ([UIColor whiteColor])

@interface MYViewController ()
{
    UIImageView * photov;
    NSData * picdata;
    NSString * avatarId;
    
    
    //我的
    UIButton * mybtn;
    UIImageView * myV;
    UIImageView * myview;
    UIImageView * myview1;

    
    UIImageView * ServiceV1;
    
 
}
@property(strong, nonatomic) UICollectionView * collectionVC;
@property(strong, nonatomic) NSArray * meunTitle;



@end

@implementation MYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBA(236,236,236,1);
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"退出图标@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];


    
    [self view11];
   
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([UserInfo shareUserInfo].iconFilePath ) {
        photov.image =[UIImage imageWithContentsOfFile:[UserInfo shareUserInfo].iconFilePath];
        
    }
}



/**
 *  "我的" 界面 ＝＝＝   2015－10-29
 *
 */
-(void)view11
{

    _dataDic = [[NSUserDefaults standardUserDefaults] objectForKey:UserData];
  
    //省
    NSString * provincestr = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"province"]];
    //市
    NSString * citystr = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"city"]];
    //区
    NSString * countystr = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"county"]];
    //电话
    NSString * mobile = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"mobile"]];
    //账户余额
    NSString * money = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"money"]];
    //下级会员个数
    NSString * membercount = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"membercount"]];
    //推荐人数
    NSString * refercount = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"refercount"]];
    
    //账号跟邮箱
    NSString * accountstr = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"account"]];
    NSString * emailstr = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"email"]];
    
    [[NSUserDefaults standardUserDefaults] setObject:emailstr forKey:USERemail];
    
    //头像
    avatarId = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"avatarId"]];
    
    NSString * avatarIdStr = [NSString stringWithFormat:@"http://demo.315bnx.com/img-s/upload/profile/avatar/%@-m.jpg",avatarId];
    picdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:avatarIdStr]];
    //    photov.image =[UIImage imageWithData:picdata];
    
    
    NSString * addresssStr = [NSString stringWithFormat:@"%@-%@-%@",provincestr,citystr,countystr];
    NSString * refercountStr = [NSString stringWithFormat:@"%@人",refercount];
    NSString * membercountStr = [NSString stringWithFormat:@"%@人",membercount];
    

    //
    myview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, UI_SCREEN_WIDTH, UI_SCREEN_WIDTH/640*207)];
    myview.backgroundColor = [UIColor whiteColor];
    myview.userInteractionEnabled = YES;
    [self.view addSubview:myview];
    
    
    //6条线   第一条   (距离 _navigation 的  距离   150)
    photov = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*60  , UI_SCREEN_WIDTH/640*30, UI_SCREEN_WIDTH/640*115, UI_SCREEN_WIDTH/640*115)];
    photov.backgroundColor = [UIColor clearColor];
    photov.layer.cornerRadius = photov.frame.size.width/2;
    //判断是否有头像照片
    if ([UserInfo shareUserInfo].iconFilePath ) {
        photov.image =[UIImage imageWithContentsOfFile:[UserInfo shareUserInfo].iconFilePath];
        
    }else
    {
        [photov setImage:[UIImage imageNamed:@"修改头像图标@3x.png"]];
    }
    

    photov.layer.masksToBounds = YES;
    [myview addSubview:photov];
    
    
    //头像
    UIButton * mypicbtn = [[UIButton alloc]init];
    mypicbtn.frame = CGRectMake( UI_SCREEN_WIDTH/640*60  , UI_SCREEN_WIDTH/640*30, UI_SCREEN_WIDTH/640*100, UI_SCREEN_WIDTH/640*100);
//    [mypicbtn setImage:[UIImage imageNamed:@"我的-头像@3x.png"] forState:UIControlStateNormal];
    [mypicbtn addTarget:self action:@selector(changepicbtn) forControlEvents:UIControlEventTouchUpInside];
    mypicbtn.backgroundColor = [UIColor clearColor];

    [myview addSubview:mypicbtn];
    
    
//头像下的名字
    UILabel * mynamelab = [[UILabel alloc]init];
    mynamelab.frame = CGRectMake( UI_SCREEN_WIDTH/640*40  , mypicbtn.bottom + UI_SCREEN_WIDTH/640*20, UI_SCREEN_WIDTH/640*140, UI_SCREEN_WIDTH/640*40);
    mynamelab.text = accountstr;
    mynamelab.font = [UIFont boldSystemFontOfSize:13];
    //    mynamelab.backgroundColor = [UIColor yellowColor];
    mynamelab.textColor = [UIColor blackColor];
    mynamelab.textAlignment = NSTextAlignmentCenter;
    [myview addSubview:mynamelab];
    
    
    
    UILabel * mymoneylab = [[UILabel alloc]init];
    mymoneylab.frame = CGRectMake( UI_SCREEN_WIDTH/640*245  , UI_SCREEN_WIDTH/640*54, UI_SCREEN_WIDTH/640*125, UI_SCREEN_WIDTH/640*30);
    mymoneylab.text = @"账户余额:";
    mymoneylab.font = [UIFont boldSystemFontOfSize:13];
//    mymoneylab.backgroundColor = [UIColor yellowColor];
    mymoneylab.textColor = [UIColor blackColor];
    mymoneylab.textAlignment = NSTextAlignmentLeft;
    [myview addSubview:mymoneylab];
    
    
    UILabel * moneylab = [[UILabel alloc]init];
    moneylab.frame = CGRectMake( mymoneylab.right  , UI_SCREEN_WIDTH/640*54, UI_SCREEN_WIDTH/640*170, UI_SCREEN_WIDTH/640*30);
    //    lab0011.backgroundColor = [UIColor redColor];
    moneylab.text = money;
    moneylab.font = [UIFont boldSystemFontOfSize:13];
    moneylab.textColor = [UIColor blackColor];
    moneylab.textAlignment = NSTextAlignmentLeft;
    [myview addSubview:moneylab];
    
    
    
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake( UI_SCREEN_WIDTH/640*245  , UI_SCREEN_WIDTH/640*105, UI_SCREEN_WIDTH/640*300, UI_SCREEN_WIDTH/640*60);
    //    lab0011.backgroundColor = [UIColor redColor];
    lab.text = @"立即变现";
    lab.font = [UIFont boldSystemFontOfSize:17];
    lab.userInteractionEnabled = YES;
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"立即变现按钮@3x.png"]];
    [lab setBackgroundColor:color];
    
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [myview addSubview:lab];
    
    
    UIImageView * monerV = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*275, UI_SCREEN_WIDTH/640*120, UI_SCREEN_WIDTH/640*30, UI_SCREEN_WIDTH/640*30)];
    [monerV setImage:[UIImage imageNamed:@"立即变现图标@3x.png"]];
//        monerV.backgroundColor = [UIColor redColor];
    [myview addSubview:monerV];
    
    
    UIButton * moneybtn = [[UIButton alloc]init];
    moneybtn.frame = CGRectMake( UI_SCREEN_WIDTH/640*245  , UI_SCREEN_WIDTH/640*105, UI_SCREEN_WIDTH/640*300, UI_SCREEN_WIDTH/640*60);
    //    [login0011 setImage:[UIImage imageNamed:@"服务商家icon@3x"] forState:UIControlStateNormal];
    [moneybtn addTarget:self action:@selector(mymoneybtn) forControlEvents:UIControlEventTouchUpInside];
    moneybtn.backgroundColor = [UIColor clearColor];
    [myview addSubview:moneybtn];
    
    
    
    
    //信息背景框下面的背景
    
    myview1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, myview.bottom + UI_SCREEN_WIDTH/640*20, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - myview.bottom-UI_SCREEN_WIDTH/640)];
    myview1.backgroundColor = [UIColor whiteColor];
    myview1.userInteractionEnabled = YES;
    [self.view addSubview:myview1];
    
    
    //信息背景框
    UIImageView * mynewsview = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*40, UI_SCREEN_WIDTH/640*30, UI_SCREEN_WIDTH/640*560, UI_SCREEN_WIDTH/640*450)];
//    mynewsview.backgroundColor = [UIColor whiteColor];
    [mynewsview setImage:[UIImage imageNamed:@"信息背景框@2x.png"]];
    mynewsview.userInteractionEnabled = YES;
    [myview1 addSubview:mynewsview];
    
    
    //三条线   第一条
    UIImageView * line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, UI_SCREEN_WIDTH/640*90, UI_SCREEN_WIDTH/640*560, UI_SCREEN_WIDTH/640*2)];
    line1.backgroundColor = RGBA(236,236,236,1);
//    myview1.userInteractionEnabled = YES;
    [mynewsview addSubview:line1];
    
    
    
    //三条线   第二条
    UIImageView * line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, UI_SCREEN_WIDTH/640*182, UI_SCREEN_WIDTH/640*560, UI_SCREEN_WIDTH/640*2)];
    line2.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [mynewsview addSubview:line2];
    
    
    
    
    //三条线   第三条
    UIImageView * line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, UI_SCREEN_WIDTH/640*274, UI_SCREEN_WIDTH/640*560, UI_SCREEN_WIDTH/640*2)];
    line3.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [mynewsview addSubview:line3];
    
 
    
    
    //四个图标   第一个
    UIImageView * imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, UI_SCREEN_WIDTH/640*20, UI_SCREEN_WIDTH/640*50, UI_SCREEN_WIDTH/640*50)];
    [imgV1 setImage:[UIImage imageNamed:@"电话图标@3x.png"]];
    imgV1.userInteractionEnabled = YES;
    [mynewsview addSubview:imgV1];
    
    
    
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake( UI_SCREEN_WIDTH/640*100  , UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*120, UI_SCREEN_WIDTH/640*40);
    //    lab0011.backgroundColor = [UIColor redColor];
    lab1.text = @"电话";
    lab1.font = [UIFont boldSystemFontOfSize:14];
    lab1.textColor = RGBA(151,151,151,1);
    lab1.textAlignment = NSTextAlignmentLeft;
    [mynewsview addSubview:lab1];
    
    
    
    UILabel * lab11 = [[UILabel alloc]init];
    lab11.frame = CGRectMake( UI_SCREEN_WIDTH/640*220  , UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*325, UI_SCREEN_WIDTH/640*40);
    //    lab11.backgroundColor = [UIColor redColor];
    lab11.text = mobile;
    lab11.font = [UIFont boldSystemFontOfSize:14];
//    lab11.textColor = [UIColor blackColor];
    lab11.textAlignment = NSTextAlignmentRight;
    [mynewsview addSubview:lab11];
    
    
    //四个图标   第二个
    UIImageView * imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*35, line1.bottom + UI_SCREEN_WIDTH/640*20, UI_SCREEN_WIDTH/640*40, UI_SCREEN_WIDTH/640*50)];
    [imgV2 setImage:[UIImage imageNamed:@"地址图标@3x.png"]];
    imgV2.userInteractionEnabled = YES;
    [mynewsview addSubview:imgV2];
    
    
    UILabel * lab2 = [[UILabel alloc]init];
    lab2.frame = CGRectMake( UI_SCREEN_WIDTH/640*100  , line1.bottom +UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*120, UI_SCREEN_WIDTH/640*40);
    //    lab0011.backgroundColor = [UIColor redColor];
    lab2.text = @"地址";
    lab2.font = [UIFont boldSystemFontOfSize:14];
    lab2.textColor = RGBA(151,151,151,1);
    lab2.textAlignment = NSTextAlignmentLeft;
    [mynewsview addSubview:lab2];
    
    
    
    UILabel * lab22 = [[UILabel alloc]init];
    lab22.frame = CGRectMake( UI_SCREEN_WIDTH/640*220  , line1.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*325, UI_SCREEN_WIDTH/640*40);
    //    lab22.backgroundColor = [UIColor redColor];
    lab22.text = addresssStr;
    lab22.font = [UIFont boldSystemFontOfSize:14];
    //    lab22.textColor = [UIColor blackColor];
    lab22.textAlignment = NSTextAlignmentRight;
    [mynewsview addSubview:lab22];
    
    
    //四个图标   第三个
    UIImageView * imgV3 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*25, line2.bottom +UI_SCREEN_WIDTH/640*20, UI_SCREEN_WIDTH/640*60, UI_SCREEN_WIDTH/640*50)];
    [imgV3 setImage:[UIImage imageNamed:@"下级会员图标@3x.png"]];
    imgV3.userInteractionEnabled = YES;
    [mynewsview addSubview:imgV3];
    
    
    UILabel * lab3 = [[UILabel alloc]init];
    lab3.frame = CGRectMake( UI_SCREEN_WIDTH/640*100  , line2.bottom +UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*120, UI_SCREEN_WIDTH/640*40);
    //    lab0011.backgroundColor = [UIColor redColor];
    lab3.text = @"我的会员";
    lab3.font = [UIFont boldSystemFontOfSize:14];
    lab3.textColor = RGBA(151,151,151,1);
    lab3.textAlignment = NSTextAlignmentLeft;
    [mynewsview addSubview:lab3];
    
    
    
    UILabel * lab33 = [[UILabel alloc]init];
    lab33.frame = CGRectMake( UI_SCREEN_WIDTH/640*220  , line2.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*325, UI_SCREEN_WIDTH/640*40);
    //    lab33.backgroundColor = [UIColor redColor];
    lab33.text = membercountStr;
    lab33.font = [UIFont boldSystemFontOfSize:14];
    //    lab33.textColor = [UIColor blackColor];
    lab33.textAlignment = NSTextAlignmentRight;
    [mynewsview addSubview:lab33];
    
    
    //四个图标   第四个
    UIImageView * imgV4 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*25, line3.bottom +UI_SCREEN_WIDTH/640*20, UI_SCREEN_WIDTH/640*60, UI_SCREEN_WIDTH/640*50)];
    [imgV4 setImage:[UIImage imageNamed:@"推荐人数图标@3x.png"]];
    imgV4.userInteractionEnabled = YES;
    [mynewsview addSubview:imgV4];
    
    
    UILabel * lab4 = [[UILabel alloc]init];
    lab4.frame = CGRectMake( UI_SCREEN_WIDTH/640*100  ,line3.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*120, UI_SCREEN_WIDTH/640*40);
    //    lab0011.backgroundColor = [UIColor redColor];
    lab4.text = @"推荐人数";
    lab4.font = [UIFont boldSystemFontOfSize:14];
    lab4.textColor = RGBA(151,151,151,1);
    lab4.textAlignment = NSTextAlignmentLeft;
    [mynewsview addSubview:lab4];
    
    
    
    UILabel * lab44 = [[UILabel alloc]init];
    lab44.frame = CGRectMake( UI_SCREEN_WIDTH/640*220  , line3.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*325, UI_SCREEN_WIDTH/640*40);
    //    lab44.backgroundColor = [UIColor redColor];
    lab44.text = refercountStr;
    lab44.font = [UIFont boldSystemFontOfSize:14];
    //    lab44.textColor = [UIColor blackColor];
    lab44.textAlignment = NSTextAlignmentRight;
    [mynewsview addSubview:lab44];
    
    UIImageView * line4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lab44.frame)+10, UI_SCREEN_WIDTH/640*560, UI_SCREEN_WIDTH/640*2)];
    line4.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [mynewsview addSubview:line4];
    
    
   
    
    
    
    
    
    
    
    
    
    
    UIButton * sharebtn = [[UIButton alloc]init];
    sharebtn.frame = CGRectMake( UI_SCREEN_WIDTH/640*120  , mynewsview.bottom + UI_SCREEN_WIDTH/640*110, UI_SCREEN_WIDTH/640*400, UI_SCREEN_WIDTH/640*70);
//        [sharebtn setImage:[UIImage imageNamed:@"分享按钮@3x.png"] forState:UIControlStateNormal];
    [sharebtn setBackgroundImage:[UIImage imageNamed:@"分享按钮@3x.png"] forState:UIControlStateNormal];

    [sharebtn addTarget:self action:@selector(sharebtnaction) forControlEvents:UIControlEventTouchUpInside];
//    sharebtn.backgroundColor = [UIColor yellowColor];
    [sharebtn setTitle:@"分享给好友" forState: UIControlStateNormal];
    sharebtn.titleLabel.font = [UIFont systemFontOfSize: 18];
//    [sharebtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [myview1 addSubview:sharebtn];
    
    
    
    
    
}










#pragma mark --  点击“我的头像”按钮
-(void)changepicbtn
{
    
    
    
    
    //跳转到个人信息界面
    MyInformationViewController * myinformationV = [[MyInformationViewController alloc]init];
    
    if ([avatarId isEqualToString:@""]) {
        myinformationV.picdata1 = nil;
    }else
    {
        myinformationV.picdata1 = picdata;
    }
    
    [self.navigationController pushViewController:myinformationV animated:YES];
    
    //
}








//点击“立即变现”按钮
-(void)mymoneybtn
{
    //
    //
    NSLog(@"点击了    “立即变现”    的按钮");
    //
}



//点击“分享给好友”按钮
-(void)sharebtnaction
{
    //
    //
    
    
//    SendMessageToWXReq* www = [[SendMessageToWXReq alloc] init];
//    www.text = @"这是测试发送的内容。";
//    www.bText = YES;
//    www.scene = WXSceneSession;
//    
//    [WXApi sendReq:www];
    
    
    
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"downloadicon" ofType:@"jpg"];
    
    //构造分享内容
    NSDictionary * infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString * appName = @"来我这";
    NSString * carPlusURL = kDownappHtml;
    NSString * contenStr = [NSString stringWithFormat:@"[%@]%@",appName,carPlusURL];
    
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



-(void)goback
{
    //
    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *loNa = [[UINavigationController alloc]initWithRootViewController:login];
    loNa.navigationBarHidden = YES;
    [self presentViewController:loNa animated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
    
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
