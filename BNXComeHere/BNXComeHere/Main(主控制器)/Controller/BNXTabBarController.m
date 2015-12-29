//
//  BNXTabBarController.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import "myInfomationVC.h"
#import "BNXNavigationController.h"
#import "MYViewController.h"
#import "ProductHomeVC.h"
#import "InvestViewController.h"
#import "BNXTabBar.h"
#import "BNXTabBarController.h"

@interface BNXTabBarController ()<BNXTabBarDelegate>
@property (nonatomic,weak)BNXTabBar *customTabBar;

@end

@implementation BNXTabBarController




- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tabBar 不先初始化tabBar 的话，传入初始化子控制器方法的tabBar为nil
    [self setupTabBar];
    
    //初始化所有子控制器
    [self setupAllChildViewContoller];
    
    self.selectedIndex = 1;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //删除系统tabBar的button
    for (UIView *child in self.tabBar.subviews) {
        //UITabBarButton 是私有类，只能找他的父类
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

//初始化tabBar
- (void)setupTabBar{
    BNXTabBar *customTabBar = [[BNXTabBar alloc]init];
    //设置bouns是x和y都为0，宽高和tabBar相同
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    self.customTabBar.delegate = self;
}

//监听tabBar按钮的改变
- (void)tabBar:(BNXTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to{
    self.selectedIndex = to;
}

- (void)setupAllChildViewContoller{
    
    //首页
    myInfomationVC *homeVC = [[myInfomationVC alloc]init];
    [self setUpChildViewController:homeVC title:@"我的" imageName:@"我的-未选中@3x.png" selectedImageName:@"我的-选中@3x.png"];
    
    //消息
    ProductHomeVC *messageVC = [[ProductHomeVC alloc]init];
    [self setUpChildViewController:messageVC title:@"服务" imageName:@"服务-未选中@3x.png" selectedImageName:@"服务-选中@3x.png"];
    
    
    //广场
    InvestViewController *squareVC = [[InvestViewController alloc]init];
    [self setUpChildViewController:squareVC title:@"投资" imageName:@"投资-未选中@3x.png" selectedImageName:@"投资选中@3x.png"];
    
    
    
}

- (void)setUpChildViewController:(UIViewController *)childVC title:(NSString *)title  imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     BNXNavigationController *NC = [[BNXNavigationController alloc] initWithRootViewController:childVC];
    //    UINavigationController *NC  = [[UINavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:NC];
    
    //添加tabBar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVC.tabBarItem];
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
