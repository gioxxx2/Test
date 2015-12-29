//
//  MyQRCodeVC.m
//  BNXComeHere
//
//  Created by lanou on 15/12/26.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "UserInfo.h"
#import "UIImage+LXDCreateBarcode.h"
#import "MyQRCodeVC.h"

@interface MyQRCodeVC ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backImageV;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageV;

@end

@implementation MyQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"我的二维码";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    self.view.backgroundColor = RGBA(0, 142, 227, 1);
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    self.backBtn.layer.borderWidth = 1;
    self.backBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.backBtn.layer.cornerRadius = 20;
    
    self.iconView.layer.cornerRadius = 39;
    self.iconView.image = self.iconImage;
//    NSString * str = [NSString stringWithFormat:@"http://demo.315bnx.com/register.html?referId=%@",[UserInfo shareUserInfo].userId];
    self.QRCodeImageV.image = [UIImage imageOfQRFromURL:userQRCodeUrl codeSize:160 red:0 green:0 blue:0 insertImage:[UIImage imageNamed:@"icon"] roundRadius:15.0f];
    

}



- (IBAction)goback:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
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
