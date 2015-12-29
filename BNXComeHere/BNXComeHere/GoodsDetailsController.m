//
//  GoodsDetailsController.m
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//
#import "bannerScrollView.h"
#import "ShoppingCart.h"
#import "GoodsDetailsController.h"
#import "GoodsDetailsCell.h"
#import "ScrollView.h"
#import "MBProgressHUD.h"
#import "UIView+UIViewEx.h"
#import "OrderPayController.h"
#import "AlertHelper.h"
#import "GoodsViewController.h"
#import "GoodsInfoModel.h"
#import "GoodsInfo.h"
#define GetHeight [UIScreen mainScreen].bounds.size.height //获取屏幕高度
#define GetWidth [UIScreen mainScreen].bounds.size.width  //获取屏幕宽度
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
@interface GoodsDetailsController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>
@property(strong, nonatomic) UITableView * tabView;
@property(strong, nonatomic) ScrollView * scrollV;
@property(strong, nonatomic) UIView * footView;
@property(strong, nonatomic) MBProgressHUD * HUD;
@property(strong, nonatomic) UIScrollView * webScroll;
@property(strong, nonatomic) UIWebView * photo;
@property(strong, nonatomic) NSMutableArray * mutaArr;
@property(strong, nonatomic) UILabel * labNum;
@property (nonatomic,assign) NSInteger countOfProduct;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,retain) NSNotification *notification;
@end

@implementation GoodsDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    //购物车数量
    _labNum = [[UILabel alloc]initWithFrame:CGRectMake(GetWidth-31.5,8,40,12)];
  


    _labNum.font = [UIFont systemFontOfSize:11.0f];
    _labNum.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:_labNum];
    self.mutaArr = [[NSMutableArray array]init];
    
    self.countOfProduct = 1;

    
    [self creatTableView];
    
    [self creatNavBar];
    
    [self creatSettlement];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillShowNotification object:nil];

    
}


#pragma mark --  键盘改变通知
- (void)keyboardWillChange:(NSNotification *)notification{

    
    
    if (notification.name == UIKeyboardWillShowNotification) {
        //3.执行动画

        [self.tabView setContentOffset:CGPointMake(0, 120) animated:YES];
        
    }
}


- (void)creatNavBar{
    self.title = @"商品详情";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回键"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAciton:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"列表-购物车"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


-(void)leftAciton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)rightAction:(UIButton *)sender
{
    GoodsViewController * shoppVC = [[GoodsViewController alloc]init];
    [self.navigationController pushViewController:shoppVC animated:YES];
}
#pragma mark*********创建导航栏***********
-(void)creatNav
{
    self.title = @"商品详情" ;
    self.view.backgroundColor = [UIColor whiteColor];
    //改变导航栏返回按钮颜色
    [self.navigationController.navigationBar  setTintColor:[UIColor  whiteColor]];
    //隐藏、去掉 导航栏返回按钮中的文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
}


#pragma mark********创建tabview*************
-(void)creatTableView
{
    self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, GetWidth, GetHeight-60) style:UITableViewStylePlain];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    self.tabView.tableFooterView = [[UIView alloc]init];
    self.tabView.backgroundColor = [UIColor clearColor];
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabView.showsHorizontalScrollIndicator = NO;
    
    //组头
    //图片展示
   
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.pro.pics.count; i++) {
//       NSString *urlS = [NSString stringWithFormat:demoLargeImagUrl,self.pro.vendor,self.pro.pics[i]];
        NSString *urlS = imageProduct(self.pro.vendor, self.pro.pics[i], @"l");
        [arr addObject:urlS];
    }
     bannerScrollView *banS = [bannerScrollView bannerScrollVWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300) array:arr];
    banS.tapBlock = ^(NSInteger index){
        
    };
    self.tabView.tableHeaderView = banS;
    [self.view addSubview:self.tabView];
}
#pragma mark********tabview的代理*************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"orderCell";
    GoodsDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [GoodsDetailsCell newCellWithProduct:self.pro];
        cell.texCount.delegate = self;
        self.cellHeight = cell.cellHeight;
        cell.tag = 1059;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:cell.texCount];
        self.notification = [NSNotification notificationWithName:UITextFieldTextDidChangeNotification object:cell.texCount];
        cell.block = ^(NSInteger a){
            self.countOfProduct = a;
        };
    }
    
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.cellHeight;
}



#pragma mark********结算*************
-(void)creatSettlement
{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, GetHeight-60, GetWidth, 60)];
    bgView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:bgView];
    
    UIButton * btnShopping = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnShopping.frame = CGRectMake(50, 15, 100, 35);
    [btnShopping setBackgroundImage:[UIImage imageNamed:@"详情页-加入购物车按钮"] forState:UIControlStateNormal];
    [btnShopping setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnShopping setTitle:@"加入购物车" forState:UIControlStateNormal];
    btnShopping.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [btnShopping addTarget:self action:@selector(btnShopingAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnShopping];
    
    UIButton * btnSet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSet.frame = CGRectMake(GetWidth-150, 15, 100, 35);
    [btnSet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSet setBackgroundImage:[UIImage imageNamed:@"详情页-立即购买按钮"] forState:UIControlStateNormal];
    [btnSet setTitle:@"立即购买" forState:UIControlStateNormal];
    btnSet.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [btnSet addTarget:self action:@selector(btnSetAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnSet];
    
}





-(void)btnShopingAction:(UIButton *)sender
{
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *valueArr = [[ShoppingCart shareShoppingCart] arrayOfShoppingCartWithProductId:self.pro.productId];
#pragma mark -- 创建商品id对应的商品数组，没有就创建，有就直接添加
    for (int i = 0; i < self.countOfProduct; i++) {
        if (valueArr.count > 0) {
            [valueArr addObject:[self.pro mutableCopy]];
        }else{
            [arr addObject:[self.pro mutableCopy]];
            [[ShoppingCart shareShoppingCart].dataDic setObject:arr forKey:self.pro.productId];
        }
    }
    int count = 0;
    for (NSString *str in [ShoppingCart shareShoppingCart].dataDic.allKeys) {
        NSArray *arr = [ShoppingCart shareShoppingCart].dataDic[str];
        count += arr.count;
    }
    _labNum.text = [NSString stringWithFormat:@"%d",count];
     NSInteger amount = [self.pro.amount integerValue];
    if (self.countOfProduct > 0) {
        if (self.countOfProduct > amount) {
            [AlertHelper showOneSecond:@"添加失败，商品数量超过库存" andDelegate:self.view];
        }else{
             [AlertHelper showOneSecond:@"添加成功，在购物车等亲～" andDelegate:self.view];
        }
        
    }else{
        [AlertHelper showOneSecond:@"添加失败，商品数量为0" andDelegate:self.view];
    }

}




#pragma mark -- textField代理 只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [self validateNumber:string];
}





- (BOOL)validateNumber:(NSString*)number {
   

    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    
    
    return res;
}


#pragma mark -- 移除观察者
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -- textview代理
- (void)textDidChange:(NSNotification *)notification{
    UITextField *textfield = notification.object;
    NSInteger count = [textfield.text integerValue];


    self.countOfProduct = count;
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _labNum.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _labNum.hidden = NO;
    _labNum.text = [NSString stringWithFormat:@"%ld",[[ShoppingCart shareShoppingCart] countOfAllValueArrayCount]];
}

-(void)btnSetAction:(UIButton *)sender
{
    OrderPayController *PayVC = [[OrderPayController alloc]init];
    NSMutableArray *proArr = [NSMutableArray array];
    if (self.countOfProduct == 0 && [self.pro.express integerValue] == 0) {
         [AlertHelper showOneSecond:@"对不起，金额为0元，无法结算" andDelegate:self.view];
    }else{
         NSInteger amount = [self.pro.amount integerValue];
        if (self.countOfProduct > amount) {
            [AlertHelper showOneSecond:@"结算失败，商品数量超过库存" andDelegate:self.view];
        }else{
            for (int i = 0; i < self.countOfProduct; i++) {
                product *pro = [self.pro mutableCopy];
                [proArr addObject:pro];
            }
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:proArr forKey:self.pro.productId];
            PayVC.productDic = dic;
            PayVC.isBuyFromShoppingCart = NO;
            [self.navigationController pushViewController:PayVC animated:YES];
        }
        
    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSData *)archie:(id)obj
{
    NSMutableData * data = [[NSMutableData alloc]init];
    NSKeyedArchiver * key = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [key encodeObject:obj forKey:@"goods"];
    [key finishEncoding];
    return data;
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
