//
//  Header.h
//  BNXComeHere
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 linyj. All rights reserved.
//

#ifndef BNXComeHere_Header_h
#define BNXComeHere_Header_h

//#import "UIView+ViewFrameGeometry.h"
//#import "NavigationBar.h"
//#import "AFNetworking.h"
//#import "SIAlertView+Normal.h"




//给用户展示的下载地址
#define kDownappHtml @"http://www.baidu.com"



//shareSdk     （没用到ID）
#define ShareSdkAppKey @"a6d6090d763a"


//微信
#define WeChatAppId @"wx757b81401a0fc8af"
#define WeChatAppSecret @"fd145bb808aba37df28bcc1d860b7e58"



//域名设置

#define Address @"http://121.43.159.163/" //测试域名
//demo域名
#define demoAddress11 @"demo.315bnx.com"

#define demoAddress @"prod.315bnx.com"


//#define demoMiddlegUrl @"http://demo.315bnx.com/img-s/upload/%@/%@-m.jpg"
//#define demoLargeImagUrl @"http://demo.315bnx.com/img-s/upload/%@/%@-l.jpg"
//#define demoSmallImagUrl @"http://demo.315bnx.com/img-s/upload/%@/%@-s.jpg"
//#define testMiddlegsUrl @"http://121.43.159.163:82/img-s/upload/%@/%@-m.jpg"
//#define testLargeImgUrl @"http://121.43.159.163:82/img-s/upload/%@/%@-l.jpg"
//#define testSmallImgUrl @"http://121.43.159.163:82/img-s/upload/%@/%@-s.jpg"

//私钥
#define PPrivateKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMRaCj+beQCLb0xHOuaRBZ1jVlTNpL0bSPWK8utflSzk5TYnKtq3ibTF9ra++/nBw1GS2EgZI0XUMWURr8Y9nbwEtDmreMYZ11snSVEshedHnonl/qEWNtXylgO3pf73Vn3yG2G43JzoIg4RCOcJTNaglKAufFdsE5AZHr9pcswXAgMBAAECgYACTdAq+OcNk5VFvtw5EmCPfTfpHNSfB2/uuaeqDWARu8nYvdLp6BdskJoZgNoyDwz8qw1woyLf0eKWfgOi/twX8GSBVy3VlM+BzERJI/8lWOX1ymqlyUPjMTLznWR1X6A+llmsWHp0bENlEY54Y19dTCFXiN6isbys6tMlWDeYSQJBAP5XXj244gozxgIhA60lorXTVTBqya5rnXbrv0dAVvcsCNcCYw1+V+zzAHvtvZkD6p4GeGPzVtN1gLjQQQUxo7UCQQDFodszbxNzesQoyp9MA5txETfpsmaU2A0tYsF+r/iIyC5VRLS3FhAk22J89TrNPwt4hZyRjXmlz3G/frUzAWgbAkEA+pmg/JW2+jBrD9vxoF+twxOYI12EnDviabL8w7qMNXwItbjfWgM7pPcFahYkMqkeOVfMtUalLTLggriG6BQx5QJBAML4MJYHSLsuLALKEmkdTeY3xF9K3qSMmENkH9vpoljek8cPJvFQVNDnlbwM+duuDJTzy0hUt+P6SQ9P41bUVm0CQGj11FzjjDXqxpm10h3jfa2TN8Rgc/AxMIuTuLdUKXTK3BACwErH3QJUTiOloucFUQ4M2kZpQ6WY+aqn3NJdc+A="




// 1 登陆URL
#define loginUrl [[NSString alloc] initWithFormat:@"http://%@/member/user/app/login?",demoAddress]

// 2 注册获取验证码url
#define registCodeUrl [[NSString alloc] initWithFormat:@"http://%@/member/user/app/register/sms/code?",demoAddress]

// 3 注册
#define registUrl [[NSString alloc] initWithFormat:@"http://%@/member/user/app/register",demoAddress]

// 4. 忘记密码
#define forgetPasswordUrl [[NSString alloc] initWithFormat:@"http://%@/member/user/app/password/forget?",demoAddress]

//5 忘记密码获取验证码
#define forgetPasswordCodeUrl [[NSString alloc] initWithFormat:@"http://%@/member/user/app/password/code?",demoAddress]

// 6 用户信息轮询
#define UserinfoUpdateUrl [NSString stringWithFormat:@"http://%@/member/user/app/info",demoAddress]

// 7 商品首页的广告轮播图banner
#define ProductBannerUrl [NSString stringWithFormat:@"http://%@/WebUI/static/banner.json",demoAddress]

// 8 商品首页Url
#define ProductHomeUrl  [NSString stringWithFormat:@"http://%@/member/user/app/home/product",demoAddress]

// 9 更多商品Url
#define moreProductUrl [NSString stringWithFormat:@"http://%@/member/user/app/product",demoAddress]

// 10 历史订单
#define historyProductUrl [NSString stringWithFormat:@"http://%@/member/user/app/order/list",demoAddress]

// 11 支付Url
#define PayUrl [NSString stringWithFormat:@"http://%@/member/user/app/order?token=%@&userId=%@&deviceType=iOS",demoAddress,[UserInfo shareUserInfo].token,[UserInfo shareUserInfo].userId]

// 12 广告图片Url
#define imageBanner(imageName,imageSize,imageType) [NSString stringWithFormat:@"http://%@/WebUI/static/banner/%@-%@.%@",demoAddress,imageName,imageSize,imageType]

// 13 商品图片url
#define imageProduct(productVender,productPicId,picSize) [NSString stringWithFormat:@"http://%@/img-s/upload/%@/%@-%@.jpg",demoAddress,productVender,productPicId,picSize]

// 14 修改头像
#define editIcon [NSString stringWithFormat:@"http://%@/img-s/index.php?/profile/avatar",demoAddress]

// 15 推荐的二维码
#define userQRCodeUrl [NSString stringWithFormat:@"http://%@/register.html?referId=%@",demoAddress,[UserInfo shareUserInfo].userId]

//16  修改地址
#define editAddressUrl [[NSString alloc] initWithFormat:@"http://%@/member/user/app/address/update?",demoAddress]

// 17 修改手机号获取验证码
#define editPhoneCodeUrl [[NSString alloc] initWithFormat:@"http://%@/member/user/app/mobile/code",demoAddress]

// 18 修改手机号
#define editPhoneUrl [[NSString alloc] initWithFormat:@"http://%@/member/user/app/mobile/update",demoAddress]

// 19 修改邮箱
#define editEmailUrl [[NSString alloc] initWithFormat:@"http://%@/member/user/app/email/update",demoAddress]

// 20 修改密码
#define editPasswordUrl [[NSString alloc] initWithFormat:@"http://%@/member/user/app/password/update",demoAddress]

// 21 用户头像
#define userIconUrl [NSString stringWithFormat:@"http://%@/img-s/upload/profile/avatar/%@-m.jpg",demoAddress,[UserInfo shareUserInfo].avatarId]
// 比例系数
#define autoSizeScaleX UI_SCREEN_WIDTH/375
#define autoSizeScaleY UI_SCREEN_HEIGHT/667




#endif

#ifdef __OBJC__

#import "UIView+ViewFrameGeometry.h"
#import "NavigationBar.h"
#import "AFNetworking.h"
#import "SIAlertView+Normal.h"
#import "BNXNavigationController.h"
#import "Config.h"
#import "UserInfo.h"
#import "ShowHud.h"
#endif


#define USERName @"userName"//用户名
#define USERPsw @"userPsw"//用户密码userId
#define USERId @"userId"//用户Id
#define USERToken @"token"//用户  32 位长度 token

#define USERmobile @"mobile"//用户 手机号
#define USERemail @"email"//用户 邮箱
#define UserData @"userData" //用户数据


// SYSTEM VERSION
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsIOS7System ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] intValue] >= 8)
// SCREEN
#define UI_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UI_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define UIWIDTH(width)  width * (UI_SCREEN_WIDTH/320)

// PHONE TYPE
#define IsIphone5 ([UIScreen mainScreen].bounds.size.height == 568.0 ? YES : NO)
#define IsIphone6 ([UIScreen mainScreen].bounds.size.height == 667.0 ? YES : NO)
#define IsIphone6plus ([UIScreen mainScreen].bounds.size.height == 736.0 ? YES : NO)
#define IsIphone4 ([UIScreen mainScreen].bounds.size.height == 480.0 ? YES : NO)

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]




#define TITLECOLOR [UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f]
#define MAILLTITLECOLOR [UIColor colorWithRed:0/255.0 green:165/255.0 blue:222/255.0 alpha:1.0f]
#define SHOWSIALERTVIEW(msg) SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"来玩这" andMessage:msg];[alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault  handler:^(SIAlertView *alertView) { }];alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;alertView.backgroundStyle = SIAlertViewBackgroundStyleGradient;[alertView show];