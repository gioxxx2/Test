//
//  ProductBannerVC.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import "ProductBannerVC.h"

@interface ProductBannerVC ()<UIWebViewDelegate>
@property (nonatomic,retain)UIWebView *webView;
@end

@implementation ProductBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1.添加webView
    self.title = @"广告招商";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回键"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAciton:)];
    UIWebView *webView = [[UIWebView alloc]init];
    self.BannerUrlStr = @"http://www.315bnx.com";
    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );
    [self.view addSubview:webView];
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:self.BannerUrlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.scalesPageToFit = YES;
    self.webView = webView;

    
}
- (void)leftAciton:(UIBarButtonItem *)bar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[ShowHud shareHud] showLoadHud];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[ShowHud shareHud] showHide];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[ShowHud shareHud] showHide];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
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
