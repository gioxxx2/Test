//
//  InvestViewController.m
//  BNXComeHere
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 linyj. All rights reserved.
//
#import "UserInfo.h"
#import "InvestViewController.h"

@interface InvestViewController ()

@end

@implementation InvestViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake( UI_SCREEN_WIDTH/640*110  ,[UIScreen mainScreen].bounds.size.height/3, UI_SCREEN_WIDTH/640*450, 80);
//    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.numberOfLines = 0;
    lab1.text = [NSString stringWithFormat:@"%@你当前的会员类型为%@，升级为E站有利于快速提升财富收益",[UserInfo shareUserInfo].account,[UserInfo shareUserInfo].property];
    lab1.font = [UIFont boldSystemFontOfSize:14];
    lab1.textColor = RGBA(93,93,93,1);

    [self.view addSubview:lab1];
    
    
    
    
    
    UIButton * upgradebtn = [[UIButton alloc]init];
    upgradebtn.frame = CGRectMake( UI_SCREEN_WIDTH/640*120  , lab1.bottom + UI_SCREEN_WIDTH/640*60, UI_SCREEN_WIDTH/640*400, UI_SCREEN_WIDTH/640*70);
    //        [sharebtn setImage:[UIImage imageNamed:@"分享按钮@3x.png"] forState:UIControlStateNormal];
    
    [upgradebtn setBackgroundImage:[UIImage imageNamed:@"立即升级按钮@3x.png"] forState:UIControlStateNormal];
    
    [upgradebtn addTarget:self action:@selector(upgradebtnaction) forControlEvents:UIControlEventTouchUpInside];
    //    sharebtn.backgroundColor = [UIColor yellowColor];
    [upgradebtn setTitle:@"立即升级" forState: UIControlStateNormal];
    upgradebtn.titleLabel.font = [UIFont systemFontOfSize: 18];
    //    [sharebtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [self.view addSubview:upgradebtn];

}

//点击“立即升级”按钮
-(void)upgradebtnaction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"伴你行暂时不支持网上升级E站升级，请致电020-31160388联系工作人员申请" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
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
