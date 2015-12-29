//
//  GoodsViewController.m
//  BNXComeHere
//
//  Created by 陈华军 on 15/11/13.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "BNXTabBarController.h"
#import "AlertHelper.h"
#import "ShoppingCart.h"
#import "MYViewController.h"
#import "GoodsViewController.h"
#import "ShoppViewCell.h"
#import "GoodsInfoModel.h"
#import "OrderPayController.h"
#import "MembersViewController.h"
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define GetHeight [UIScreen mainScreen].bounds.size.height //获取屏幕高度
#define GetWidth [UIScreen mainScreen].bounds.size.width  //获取屏幕宽度


@interface GoodsViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    UITableView *_MyTableView;
    float allPrice;
    NSMutableArray *infoArr;
    BOOL isSlect;
}

@property(strong,nonatomic)UIButton *allSelectBtn;
@property(strong,nonatomic)UILabel *allPriceLab;
@property (nonatomic,retain)NSMutableArray *dataArr;
@property (nonatomic,retain)NSMutableArray *cellArr;

@end

@implementation GoodsViewController

- (NSMutableArray *)cellArr{
    if (!_cellArr) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


    [self creatNavBar];
    
   
    if ([ShoppingCart shareShoppingCart].dataDic.allKeys.count > 0) {
        
       
        
        [self creatTableView];
        [self creatSettlement];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"购物车-删除"] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];

    }else
    {
        [self initWithoutProduct];
        
    }
    
}
- (void)creatNavBar{
    self.title = @"购物车";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回键"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)initWithoutProduct{
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, GetWidth, 30)];
    lab.text = @"亲，您的购物车空空如也";
    lab.center = self.view.center;
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    UIButton * btnGoTo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnGoTo.frame = CGRectMake(0, GetHeight/2+30, GetWidth, 40);
    [btnGoTo setTitle:@"马上去逛逛" forState:UIControlStateNormal];
    [btnGoTo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnGoTo addTarget:self action:@selector(gotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnGoTo];

}






//购物车无产品时跳转
-(void)gotoAction:(UIButton *)sender
{


    BNXTabBarController *tabBarVC = [[BNXTabBarController alloc]init];
    [self presentViewController:tabBarVC animated:YES completion:nil];

}


-(void)creatTableView
{
    /**
     创建表格，并设置代理
     */
    _MyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-120+64) style:UITableViewStylePlain];
    _MyTableView.dataSource = self;
    _MyTableView.delegate = self;
    _MyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _MyTableView.delaysContentTouches = NO;
    [self.view addSubview:_MyTableView];
}


-(void)leftAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightAction:(UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除选定商品？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        for (int i = 0; i < self.cellArr.count; i++) {
            ShoppViewCell *cell = self.cellArr[i];
            if (cell.selectState == YES) {
                [[ShoppingCart shareShoppingCart].dataDic removeObjectForKey:cell.pro.productId];
                
                [self.cellArr removeObject:cell];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [_MyTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                i--;
                [self countAllPrice];
            }
            
        }
        if (self.cellArr.count == 0) {
            for (UIView *view in self.view.subviews) {
                [view removeFromSuperview];
            }
            [self initWithoutProduct];
//            self.rightButton.hidden = YES;
            self.navigationItem.rightBarButtonItem = nil;
            
        }
        
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ShoppingCart shareShoppingCart].dataDic.allKeys.count;
}



//定制单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =  @"indentify";
    ShoppViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    NSArray *keyArr = [ShoppingCart shareShoppingCart].dataDic.allKeys;
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSString *str in keyArr) {
        NSArray *valueArr = [ShoppingCart shareShoppingCart].dataDic[str];
        if (valueArr.count > 0) {
            [dataArr addObject:valueArr[0]];
        }
    }
    self.dataArr = dataArr;
    product *pro = self.dataArr[indexPath.row];
    if (!cell)
    {
        cell = [ShoppViewCell newCellWithProduct:pro];
        cell.countBlock = ^(NSInteger a){
           
            [self countAllPrice];
        };
    }
    if (self.cellArr.count > 0) {
        for (ShoppViewCell *shopCell in self.cellArr) {
            if ([shopCell.pro.productId isEqualToString:cell.pro.productId]==NO) {
                [self.cellArr addObject:cell];
                break;
            }
        }
    }else{
        [self.cellArr addObject:cell];
    }
    
   
    
    return cell;
}

//返回单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 154;
}

//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
   
        cell.selectState = !cell.selectState;
        
        //判断是否选中，是改成否，否改成是，改变图片状态
        [self judgeAllSelectBtnSelectedWithSelectState:cell.selectState];
        
        
        
        [self countAllPrice];

   
   
}

#pragma mark -- 刷新购物车
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_MyTableView reloadData ];
}


#pragma mark -- 判断全选状态
- (void)judgeAllSelectBtnSelectedWithSelectState:(BOOL)selectState{
    if (selectState == NO) {
        [self allSelectBtnSelectedWithState:NO];
    }else{
        for (ShoppViewCell *cell in self.cellArr) {
            if (cell.selectState == NO) {
                [self allSelectBtnSelectedWithState:NO];
                break;
            }else{
                [self allSelectBtnSelectedWithState:YES];
            }
        }
    }
}

- (void)allSelectBtnSelectedWithState:(BOOL)state{
    if (state == NO) {
        self.allSelectBtn.selected = NO;
        [self.allSelectBtn setBackgroundImage:[[UIImage imageNamed:@"复选框-未选中.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else{
        self.allSelectBtn.selected = YES;
        [self.allSelectBtn setBackgroundImage:[[UIImage imageNamed:@"复选框-选中.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
}


/**
 *  全选按钮事件
 *
 *  @param sender 全选按钮
 */
-(void)selectBtnClick:(UIButton *)sender
{
    //判断是否选中，是改成否，否改成是，改变图片状态
    self.allSelectBtn.selected = !self.allSelectBtn.selected;
    if (self.allSelectBtn.selected)
    {
        [sender setBackgroundImage:[[UIImage imageNamed:@"复选框-选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        CGFloat count = 0;
        for (ShoppViewCell *cell in self.cellArr) {
            cell.selectState = YES;
            NSArray *proArr = [[ShoppingCart shareShoppingCart] arrayOfShoppingCartWithProductId:cell.pro.productId];
            count += proArr.count * [cell.pro.memberPrice integerValue];
            
        }
        count /= 100;
        self.allPriceLab.text = [NSString stringWithFormat:@"%.2f元",count];
        
        
    }else{
        
        [sender setBackgroundImage:[[UIImage imageNamed:@"复选框-未选中.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        for (ShoppViewCell *cell in self.cellArr) {
            cell.selectState = NO;
        }
        self.allPriceLab.text = @"¥0.00元";
        
    }
    
 
    
}


#pragma mark -- 计算总价格
- (void)countAllPrice{
    CGFloat count = 0;
    for (ShoppViewCell *cell in self.cellArr) {
        if (cell.selectState == YES) {
            NSArray *proArr = [[ShoppingCart shareShoppingCart] arrayOfShoppingCartWithProductId:cell.pro.productId];
            count += proArr.count * [cell.pro.memberPrice integerValue];
        }
    }
    count /= 100;
    self.allPriceLab.text = [NSString stringWithFormat:@"%.2f元",count];
}


#pragma mark********结算*************
-(void)creatSettlement
{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, GetHeight-60, GetWidth, 80)];
    bgView.backgroundColor = kColor(245, 245, 245);
    [self.view addSubview:bgView];
    
    UILabel * lab3 = [[UILabel alloc]initWithFrame:CGRectMake(45, 20, 40, 20)];
    lab3.text = @"全选";
    lab3.font = [UIFont systemFontOfSize:15.0f];
    [bgView addSubview:lab3];
    
    UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(GetWidth/2-65, 20, 40, 20)];
    lab1.text = @"合计:";
    lab1.textColor = [UIColor redColor];
    lab1.font = [UIFont systemFontOfSize:15.0f];
    [bgView addSubview:lab1];
    
    self.allPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(GetWidth/2-30, 20, 100, 20)];
    _allPriceLab.text = @"¥0.00元";
    _allPriceLab.textColor = [UIColor redColor];
    _allPriceLab.font = [UIFont systemFontOfSize:15.0f];
    [bgView addSubview:_allPriceLab];
    
    UIButton * btnSet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSet.frame = CGRectMake(GetWidth-90, 15, 80, 30);
    [btnSet setBackgroundImage:[UIImage imageNamed:@"购物车-结算按钮"] forState:UIControlStateNormal];
    [btnSet setTitle:@"结算" forState:UIControlStateNormal];
    [btnSet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSet.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [btnSet addTarget:self action:@selector(btnSetAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnSet];
    
    //全选
    self.allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _allSelectBtn.backgroundColor = [UIColor whiteColor];
    _allSelectBtn.frame = CGRectMake(20, 20, 20, 20);
    [_allSelectBtn setBackgroundImage:[UIImage imageNamed:@"复选框-未选中"] forState:UIControlStateNormal];
    [_allSelectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.allSelectBtn.selected = NO;
    [bgView addSubview:_allSelectBtn];
    
}

#pragma mark -- 结算按钮事件
-(void)btnSetAction:(UIButton *)sender
{
    CGFloat count = 0;
    CGFloat express = 0;
    CGFloat proCount = 0;
    NSMutableDictionary *proDic = [NSMutableDictionary dictionary];
    for (ShoppViewCell *cell in self.cellArr) {
        if (cell.selectState == YES) {
            NSArray *proArr = [[ShoppingCart shareShoppingCart] arrayOfShoppingCartWithProductId:cell.pro.productId];
            if (proArr.count > 0) {
                [proDic setObject:proArr forKey:cell.pro.productId];
            }
            proCount += proArr.count;
            express += [cell.pro.express integerValue];
            count += proArr.count * [cell.pro.memberPrice integerValue];
        }
    }
    
    express /= 100;
    count /= 100;
    if ((count > 0 || express > 0) && proCount > 0) {
        OrderPayController * orderPayVC = [[OrderPayController alloc]init];
        orderPayVC.productDic = proDic;
        orderPayVC.isBuyFromShoppingCart = YES;
        [self.navigationController pushViewController:orderPayVC animated:YES];
    }else{
        [AlertHelper showOneSecond:@"对不起，金额为0元，无法结算" andDelegate:self.view];
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
