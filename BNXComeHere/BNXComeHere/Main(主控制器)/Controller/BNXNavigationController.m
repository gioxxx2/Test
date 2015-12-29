//
//  BNXNavigationController.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "ProductHomeVC.h"
#import "NavigationBar.h"
#import "BNXNavigationController.h"

@interface BNXNavigationController ()

@property (nonatomic,retain)NavigationBar *bar;

@end

@implementation BNXNavigationController


//第一次使用这个类的时候会调用（一个类只会调用一次）
+ (void)initialize{
    //1.设置导航栏主题
        [self setupNavBarTheme];
    
    //2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
    
    
    
}



//设置导航栏按钮主题
+ (void)setupBarButtonItemTheme{

//    [[UIBarButtonItem appearance]  setBackButtonBackgroundImage:[UIImage imageNamed:@"返回键"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
 
//    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"返回键"] forState:UIControlStateNormal style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64)  forBarMetrics:UIBarMetricsDefault];
    //设置背景
    //    [item setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    [item setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    //设置文字属性
    
    
//    NSDictionary *dic11 = @{NSForegroundColorAttributeName:[UIColor lightGrayColor]};
//    [item setTitleTextAttributes:dic11 forState:UIControlStateDisabled];
    
    //    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
    //    [item setTitleTextAttributes:dic forState:UIControlStateHighlighted];
    
}

//设置导航栏主题
+ (void)setupNavBarTheme{
    //取出appearence对象
    UINavigationBar *navBar = [UINavigationBar appearance];

    [navBar setBarTintColor:[UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f]];
    

    //设置背景
   
    //设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //        textAttrs[UITextAttributeTextShadowColor] = [UIColor blackColor];
    //    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:19];
    //    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    [navBar setTitleTextAttributes:textAttrs];
}



//push的时候隐藏tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
    [super pushViewController:viewController animated:animated];

}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
  
    return [super popToRootViewControllerAnimated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    
   return [super popViewControllerAnimated:animated];
}


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {

//        [self.navigationBar setBackgroundColor:[UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f]];
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.interactivePopGestureRecognizer.enabled = YES;
        
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
   
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
