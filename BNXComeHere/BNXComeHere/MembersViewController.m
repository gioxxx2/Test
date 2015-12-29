//
//  MembersViewController.m
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//

#import "ShoppingCart.h"
#import "MembersViewController.h"
#import "OrderRecordController.h"
#import "MembersViewCell.h"
#import "GoodsDetailsController.h"
#import "AFNetworking.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefresh.h"
#import "MYViewController.h"
#import "GoodsViewController.h"
#define GetHeight [UIScreen mainScreen].bounds.size.height //获取屏幕高度
#define GetWidth [UIScreen mainScreen].bounds.size.width  //获取屏幕宽度
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
@interface MembersViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    int _pageCount;
}
@property(strong, nonatomic) UITableView * tableV;
@property(strong, nonatomic) UISearchBar * searBar;
@property(strong, nonatomic) NSMutableArray * arrData;
@property(strong, nonatomic) UIButton * btnShopCart;
@property(strong, nonatomic) NSDictionary * tempDic;
@property (nonatomic,retain)UILabel *shoppingCartCountLabel;
@property (nonatomic,assign)NSInteger page;
@end

@implementation MembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatNavBar];
    
    self.page = 1;
    [self loadSourceWithpage:self.page];
    [self creatSearcharBar];
    [self creatBtnShoppingCart];
    
}

- (void)creatNavBar{
    self.title = @"会员套餐列表";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回键"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"订单记录"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}



#pragma mark********数据下载***********
-(void)loadSourceWithpage:(NSInteger)page
{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];

    params[@"token"] = [UserInfo shareUserInfo].token;
    params[@"pageNo"] = [NSString stringWithFormat:@"%ld",page];
    
    NSString *str = moreProductUrl;
    NSString *url = [NSString stringWithFormat:@"%@/%@",str,self.vendor];
    [[ShowHud shareHud] showLoadHud];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _tempDic = [responseObject objectForKey:@"data"];
        for (NSDictionary * dic in _tempDic) {
            product *pro = [product setupProdtctWithDic:dic];
            [self.arrData addObject:pro];
        }
        [self.tableV reloadData];
        [self.tableV.mj_footer endRefreshing];
        [[ShowHud shareHud] showHide];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableV.mj_footer endRefreshing];
        [[ShowHud shareHud] showHide];
    }];
}
#pragma mark  创建表视图
-(void)creatSearcharBar
{

    //创建tabview
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, GetWidth, GetHeight) style:UITableViewStylePlain];
//    self.tableV.backgroundColor = [UIColor yellowColor];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    NSMutableArray *imgS = [NSMutableArray array];
    for (int i = 0; i <= 42; i++) {
        NSString *str = [NSString stringWithFormat:@"%02d",i];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [imgS addObject:image];
    }
    [footer setImages:imgS duration:2 forState:MJRefreshStateRefreshing];
    self.tableV.mj_footer = footer;
    
    
    [self.view addSubview:self.tableV];
     
}


#pragma mark -- 上拉加载的状态
- (void)loadMoreData{
    self.page++;
    [self loadSourceWithpage:self.page];
}



-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightAction:(UIButton *)sender
{
    OrderRecordController * oredrVC = [[OrderRecordController alloc]init];
    [self.navigationController pushViewController:oredrVC animated:YES];
}
#pragma mark**********创建购物车按钮*************
-(void)creatBtnShoppingCart
{
    self.btnShopCart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnShopCart.frame = CGRectMake(GetWidth-70, GetHeight-80, 60, 60);
    [self.btnShopCart setBackgroundImage:[UIImage imageNamed:@"列表-购物车"] forState:UIControlStateNormal];
    [self.btnShopCart addTarget:self action:@selector(btnShopCartAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnShopCart];
    
    //购物车数量
    UILabel * labNum = [[UILabel alloc]initWithFrame:CGRectMake(GetWidth-32, GetHeight-66,12,12)];
   
    labNum.textColor = [UIColor whiteColor];
    self.shoppingCartCountLabel = labNum;
    [self.view addSubview:labNum];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.shoppingCartCountLabel.text = [NSString stringWithFormat:@"%ld",[[ShoppingCart shareShoppingCart] countOfAllValueArrayCount]];
}

-(void)btnShopCartAction:(UIButton *)sender
{
    GoodsViewController * shoppVC = [[GoodsViewController alloc]init];
    [self.navigationController pushViewController:shoppVC animated:YES];
}


/**
 * table 的代理方法
 */
#pragma mark***********table的三个代理方法********
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _arrData.count;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"memberCell";
     MembersViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [MembersViewCell newCell];
    }
    [cell setCell:self.arrData[indexPath.row]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 137;
}
/**
 * table 点击行代理
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailsController *goodDetailVC = [[GoodsDetailsController alloc]init];
    goodDetailVC.pro = self.arrData[indexPath.row];
    [self.navigationController pushViewController:goodDetailVC animated:YES];
}


-(NSMutableArray *)arrData
{
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
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
