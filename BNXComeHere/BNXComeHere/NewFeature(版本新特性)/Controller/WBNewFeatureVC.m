//
//  WBNewFeatureVC.m
//  XzWeibo
//
//  Created by 徐智 on 15/11/2.
//  Copyright © 2015年 徐智. All rights reserved.
//
#import "WBTool.h"
#import "UserInfo.h"
#import "LoginViewController.h"
#import "BNXTabBarController.h"
#import "CheckBoxButton.h"
#import "MBProgressHUD.h"
#import "WBNewFeatureVC.h"

@interface WBNewFeatureVC ()<UIScrollViewDelegate>
@property (nonatomic,retain)UIPageControl *pageControll;
@property (nonatomic,retain)CheckBoxButton *btn;
@end

@implementation WBNewFeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //0.添加背景
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    //添加scrollView
    [self setupScrollView];
    //添加pageControll
    [self setupPageControll];
}

- (void)setupPageControll{
    //1.添加
    UIPageControl *pageControll = [[UIPageControl alloc]init];
    CGFloat centerX = self.view.frame.size.width/2;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControll.center = CGPointMake(centerX, centerY);
    pageControll.bounds = CGRectMake(0, 0, 100, 30);
    pageControll.numberOfPages = 3;
    self.pageControll = pageControll;
    [self.view addSubview:pageControll];
    //2.设置圆点的颜色
    pageControll.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControll.pageIndicatorTintColor = [UIColor grayColor];
    
}

- (void)setupScrollView{
    //1.添加UIScrollView
    UIScrollView *ScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    ScrollView.pagingEnabled = YES;
    ScrollView.showsHorizontalScrollIndicator = NO;
    ScrollView.delegate = self;
    [self.view addSubview:ScrollView];
    //2.添加图片
    for (int i = 0; i < 3; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * ScrollView.frame.size.width, 0, ScrollView.frame.size.width, ScrollView.frame.size.height)];
        NSString *imageStr = nil;
       
        if ([UIScreen mainScreen].bounds.size.height < 568) {
            imageStr = [NSString stringWithFormat:@"new_feature_%d",i+1];
        }else{
            imageStr = [NSString stringWithFormat:@"引导页%d-1080×1920",i+1];
        }
       
      
        imageV.image = [UIImage imageNamed:imageStr];
        if (i == 3-1) {
            [self setupLastImageView:imageV];
        }
        [ScrollView addSubview:imageV];
    }
    ScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, 0);

}


//添加内容的最后一张图片
- (void)setupLastImageView:(UIImageView *)imageView{
    //不开交互，它的子控件button不能点击
    imageView.userInteractionEnabled = YES;
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];

    
    //2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.88;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = CGRectMake(0, 0, self.view.frame.size.width/3, 40);
//    startButton.frame = CGRectMake(100, 300, 100, 100);
    //3.设置文字
    [startButton setTitle:@"立即开始" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f];
    [imageView addSubview:startButton];
    
  

}



- (void)showHudWithTitle:(NSString *)title{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.labelText = title;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
    [hud hide:YES afterDelay:1];
}


//开始按钮点击
- (void)start{
    
    //切换窗口的根控制器  切换后，原来的版本新特性VC被销毁
 
   [WBTool chooseFisetController];

   
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControll.currentPage = scrollView.contentOffset.x/self.view.frame.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
