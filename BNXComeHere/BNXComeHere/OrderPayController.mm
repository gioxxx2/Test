//
//  OrderPayController.m
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//
#import "MyInformationViewController.h"
#import "MYViewController.h"
#import "DataSigner.h"
#import "Order.h"
#import "BNXTabBarController.h"
#import "ShoppingCart.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderPayController.h"
#import "OrderPayCell.h"
#import "OrderPayView.h"
#import "GoodsDetailsController.h"
#import "AlertHelper.h"
#import "UPPayPluginDelegate.h"
#import "UPPayPlugin.h"
#import "MBProgressHUD.h"
#import "NSDictionary+MKNKAdditions.h"
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define GetHeight [UIScreen mainScreen].bounds.size.height //获取屏幕高度
#define GetWidth [UIScreen mainScreen].bounds.size.width  //获取屏幕宽度

//#define kNormalTnUrl @"http://demo.315bnx.com/mdemo.315bnx.comember/user/app/order"
#define kResult @"支付结果: %@"
@interface OrderPayController ()<UITableViewDataSource,UITableViewDelegate,UPPayPluginDelegate,UIGestureRecognizerDelegate,orderPayDeleate>
{
    NSMutableData * _mData;
    NSMutableArray * _data;
    NSString * _idStr;  //订单ID
    NSString * _orderNoStr;//订单编号
    
}
@property(nonatomic, assign) SEL result;//这里声明为属性方便在于外部传入。
//购物车
@property(strong, nonatomic) NSArray * tempArr;
@property(copy, nonatomic) NSString * amountPrice, * amountIntegral;

//直接购买
@property(assign, nonatomic) int buyNumber;
@property(nonatomic, copy)void (^mallPayFinishPop)(void);

@property(strong, nonatomic) UITableView * tabView;
@property(strong, nonatomic) NSDictionary * dic;

@property (nonatomic,retain)OrderPayView *orderPayView;
@property (nonatomic,retain)NSString *orderText;
@end

@implementation OrderPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self creatNav];
    [self creatNavBar];
    [self creatTableView];
    [self creatSettlement];
    
    
}

- (void)creatNavBar{
    self.title = @"订单支付";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回键"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}



-(void)leftAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark*********创建导航栏***********
-(void)creatNav
{
    self.title = @"订单支付";
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
    NSArray * nibView = [[NSBundle mainBundle]loadNibNamed:@"OrderPayView" owner:nil options:nil];
    OrderPayView * orderV = [nibView objectAtIndex:0];
    orderV.deleagete = self;
    [orderV setUpWithUserData];
    self.orderPayView = orderV;
    
    self.tabView.showsVerticalScrollIndicator = NO;
    self.orderPayView = orderV;
    self.tabView.tableHeaderView = orderV;
    [self.view addSubview:self.tabView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UserInfo shareUserInfo] updateUserInfo];
    [self.orderPayView setUpWithUserData];
}

- (void)pushInfoVC{
    [self.navigationController pushViewController:[[MyInformationViewController alloc]init] animated:YES];
}


#pragma mark********tabview的代理*************

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productDic.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"orderPayCell";
    OrderPayCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSArray *keyArr = self.productDic.allKeys;
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSString *str in keyArr) {
        NSArray *valueArr = self.productDic[str];
        if (valueArr.count > 0) {
            if (self.isBuyFromShoppingCart) {
                [dataArr addObject:valueArr[0]];
            }else{
                dataArr = [NSMutableArray arrayWithArray:valueArr];
            }
        }
    }
    product *pro = dataArr[indexPath.row];
    if (!cell) {

        cell = [OrderPayCell newCellWith:pro isShoppingCart:self.isBuyFromShoppingCart count:dataArr.count];

    }
  

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


#pragma mark -- 计算运费 和 总计价格
- (NSString *)countWithResult:(NSString *)result{
    CGFloat express = 0;
    CGFloat price = 0;
    for (NSString *proID in self.productDic) {
        NSArray *ProArr = [self.productDic objectForKey:proID];
        if (ProArr.count > 0) {
            product *pro = ProArr[0];
            express += [pro.express integerValue];
            price += ProArr.count * [pro.memberPrice integerValue];
        }
    }
    price += express;
    express /= 100;
    price /= 100;
    if ([result isEqualToString:@"合计"]) {
        return [NSString stringWithFormat:@"¥%.2f",price];
    }else{
        return [NSString stringWithFormat:@"包运费￥%.2f",express];
    }
    
}


#pragma mark********结算*************
-(void)creatSettlement
{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, GetHeight-60, GetWidth, 60)];

    bgView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:bgView];
    
    
    UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 40, 20)];
    lab1.text = @"合计:";
    [bgView addSubview:lab1];
    
  
    UILabel * lab2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, 150, 20)];
    lab2.text = [self countWithResult:@"合计"];
    lab2.textColor = [UIColor redColor];
    [bgView addSubview:lab2];
    
    UILabel * lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 150, 20)];
    lab3.text = [self countWithResult:@"运费"];
    
    
//    lab3.backgroundColor = [UIColor redColor];
    lab3.textColor = [UIColor lightGrayColor];
    lab3.font = [UIFont systemFontOfSize:13.f];
    [bgView addSubview:lab3];
    
    UIButton * btnSet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSet.frame = CGRectMake(GetWidth-140, 10, 120, 35);
    [btnSet setBackgroundImage:[UIImage imageNamed:@"订单支付-支付按钮"] forState:UIControlStateNormal];
    [btnSet setTitle:@"支付" forState:UIControlStateNormal];
    [btnSet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSet.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [btnSet addTarget:self action:@selector(btnSetAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnSet];
    
}

#pragma mark -- 支付按钮事件
-(void)btnSetAction:(UIButton *)sender
{
    

    
    if (self.orderPayView.isInfoDetail == NO) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收件人为空或地址不完整" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"完善信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             [self.navigationController pushViewController:[[MyInformationViewController alloc]init] animated:YES];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if (self.orderPayView.aliPayBtn.selected == NO && self.orderPayView.uuPayBtn.selected == NO) {
        [AlertHelper showOneSecond:@"请先选择任意一种支付方式" andDelegate:self.view];
        return;
    }else if (self.orderPayView.uuPayBtn.selected){
        [[ShowHud shareHud]showHudWithText:@"对不起，现在暂不支持银联"];
//        [self uuPay];
    }else if (self.orderPayView.aliPayBtn.selected){
        [self aliPay];
    }

}

#pragma makr -- 如果是购物车过来的 结算成功后，删除原购物车结算的商品
- (void)removeProductOfShoppingCart{
    if (self.isBuyFromShoppingCart) {
        for (NSString *key in self.productDic) {
            NSMutableArray *proArr = [[ShoppingCart shareShoppingCart] arrayOfShoppingCartWithProductId:key];
            NSArray *arr = self.productDic[key];
            [proArr removeObjectsInArray:arr];
            [[ShoppingCart shareShoppingCart].dataDic removeObjectForKey:key];
            [self.productDic removeAllObjects];
            [self.tabView reloadData];
        }
    }
}


- (void)returnMemmoText:(NSString *)text{
    self.orderText = text;
}

#pragma mark  -- 支付宝支付
- (void)aliPay{
 

    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *key in self.productDic) {
        NSArray *proArr = self.productDic[key];
        if (proArr.count > 0) {
            NSMutableDictionary *proDic = [NSMutableDictionary dictionary];
            proDic[@"productId"] = key;
            proDic[@"buyCount"] = [NSString stringWithFormat:@"%lu",(unsigned long)proArr.count];
            product *pro = proArr[0];
            proDic[@"vendor"] = pro.vendor;
            [arr addObject:proDic];
        }
    }
    params[@"products"] = arr;
    params[@"payType"] = @"ALIPAY";
    params[@"memo"] = self.orderText;
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //参数传字典就好，不用String
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:PayUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = responseObject[@"data"];
        Order *order = [[Order alloc]init];
        //商户ID  partner
        order.partner = data[@"partner"];
        //账号ID  seller
        order.seller = data[@"seller_id"];
        //订单ID
        order.tradeNO = data[@"orderNo"];
        //商品标题
        order.productName = data[@"subject"];
        //商品描述
        order.productDescription = data[@"body"];
        //回调地址
        order.notifyURL = data[@"notify_url"];
        order.service = data[@"service"];
        //测试类型
        order.paymentType = data[@"payment_type"];
        //编码格式
        order.inputCharset = data[@"_input_charset"];
        order.itBPay = data[@"it_b_pay"];
        order.showUrl = @"m.alipay.com";
        //商品价格
        order.amount = data[@"total_fee"];
        
        NSString *appScheme = @"alisdkdemo";
        NSString *orderSpec = [order description];
        id<DataSigner> signer = CreateRSADataSigner(PPrivateKey);
        NSString *signedString = [signer signString:orderSpec];
        //将签名成功字符串格式化为订单字符串
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
#pragma mark -- 处理结果
/*
 resultStatus，状态码，SDK里没对应信息，第一个文档里有提到：
 
 9000 订单支付成功
 8000 正在处理中
 4000 订单支付失败
 6001 用户中途取消
 6002 网络连接出错

 */
                if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                    [self dealWithSuccessResult];
                }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){
                    [AlertHelper showOneSecond:@"支付失败" andDelegate:self.view];
                }
            }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    

    
}

#pragma mark -- 支付成功处理
- (void)dealWithSuccessResult{
#pragma mark -- 删除购物车
    [self removeProductOfShoppingCart];
    [AlertHelper showOneSecond:@"支付成功" andDelegate:self.view];
    BNXTabBarController *tabBarVC = [[BNXTabBarController alloc]init];
    [self presentViewController:tabBarVC animated:YES completion:nil];
}

#pragma mark银联支付
- (void)uuPay
{


    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *key in self.productDic) {
        NSArray *proArr = self.productDic[key];
        if (proArr.count > 0) {
            NSMutableDictionary *proDic = [NSMutableDictionary dictionary];
            proDic[@"productId"] = key;
            proDic[@"buyCount"] = [NSString stringWithFormat:@"%lu",proArr.count];
            product *pro = proArr[0];
            proDic[@"vendor"] = pro.vendor;
            [arr addObject:proDic];
        }
    }
    params[@"products"] = arr;
    params[@"payType"] = @"UPMP";
   
    
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        //参数传字典就好，不用String
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
   
        [manager POST:PayUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            _dic = [responseObject objectForKey:@"data"];
            NSString * tn = _dic[@"serialNo"];
            if (tn != nil && tn.length > 0) {
#pragma mark -- 调用银联支付， 01表示测试环境， 00表示线上环境
                [UPPayPlugin startPay:_dic[@"serialNo"] mode:@"01" viewController:self delegate:self];
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    
    
    
}




#pragma mark -- 银联返回支付结果
-(void)UPPayPluginResult:(NSString*)result
{
#pragma mark -- 返回3种状态
    if ([result isEqualToString:@"success"]) {
        [self dealWithSuccessResult];
    }else if ([result isEqualToString:@"cancel"]){
        NSLog(@"取消支付");
    }else if ([result isEqualToString:@"fail"]){
        [AlertHelper showOneSecond:@"支付失败" andDelegate:self.view];
    }
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
