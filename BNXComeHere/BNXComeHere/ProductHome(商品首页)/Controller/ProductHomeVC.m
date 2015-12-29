//
//  ProductHomeVC.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/23.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "JX_GCDTimerManager.h"
#import "LoginViewController.h"
#import "UserInfo.h"
#import "ProductBannerVC.h"
#import "BNXNavigationController.h"
#import "product.h"
#import "AFNetworking.h"
#import "bannerScrollView.h"
#import "banner.h"
#import "wineCell.h"
#import "memberView.h"
#import "ThreeProductCell.h"
#import "GoodsDetailsController.h"
#import "MembersViewController.h"
#import "ProductHomeVC.h"

@interface ProductHomeVC ()<UITableViewDataSource,UITableViewDelegate,ThreeProductCellDelegate,wineDelegate>
@property (nonatomic,strong)NSMutableArray *giftArray;
@property (nonatomic,strong)NSMutableArray *wineArray;
@property (nonatomic,strong)NSMutableArray *oilArray;
@property (nonatomic,strong)NSMutableArray *productArray;
//banner滚动视图
@property (nonatomic,retain)bannerScrollView *bannerScollV;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSTimer *timer;
@property (nonatomic,retain)NSMutableArray *allDataArray;

@end
static NSString *myTimer = @"MyTimer";

@implementation ProductHomeVC

- (NSMutableArray *)allDataArray{
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (NSMutableArray *)giftArray{
    if (!_giftArray) {
        _giftArray = [NSMutableArray array];
    }
    return _giftArray;
}

- (NSMutableArray *)wineArray{
    if (!_wineArray) {
        _wineArray = [NSMutableArray array];
    }
    return _wineArray;
}

- (NSMutableArray *)oilArray{
    if (!_oilArray) {
        _oilArray = [NSMutableArray array];
    }
    return _oilArray;
}

- (NSMutableArray *)productArray{
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  self.dataDic = [[NSUserDefaults standardUserDefaults] objectForKey:UserData];
    BNXNavigationController *bnxNC = (BNXNavigationController *)self.navigationController;
    bnxNC.naBar.titleLabel.text = @"会员服务";
    [self getProductData];
    [self creatCollectionView];
    
#pragma mark -- 60s轮询一次数据刷新
    //手动cancel掉上一个线程
    [[JX_GCDTimerManager sharedInstance] cancelTimerWithName:myTimer];
    __weak typeof(self) weakSelf = self;
    [[JX_GCDTimerManager sharedInstance] scheduledDispatchTimerWithName:myTimer timeInterval:60 queue:nil repeats:YES actionOption:AbandonPreviousAction action:^{
        [weakSelf timeAction];
    }];
    

#pragma mark -- 第一次进来跟新用户
    [[UserInfo shareUserInfo] updateUserInfo];
    

}





- (void)dealloc{
    [[JX_GCDTimerManager sharedInstance] cancelTimerWithName:myTimer];
}


- (void)timeAction{
 
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [UserInfo shareUserInfo].token;
    param[@"userId"] = [UserInfo shareUserInfo].userId;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:UserinfoUpdateUrl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            
            long long timeStampLast = [[UserInfo shareUserInfo].timestamp longLongValue];
            NSDictionary *data = responseObject[@"data"];
            long long timeStampNow = [data[@"timestamp"] longLongValue];
            if (timeStampNow != timeStampLast) {

                
#pragma mark -- 刷新数据
                [self initWithTableViewHeaderView];
                [self getProductData];
            }
            [[UserInfo shareUserInfo] setUpWithNewDic:data];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

}

#pragma mark-- 服务
-(void)creatCollectionView
{
    
    memberView *memberV = [[memberView alloc]initWithFrame:CGRectMake(0, 64, UI_SCREEN_WIDTH, 30) allMember:@"11111" myMember:self.dataDic[@"membercount"] surplus:self.dataDic[@"money"]];
    [self.view addSubview:memberV];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(memberV.frame), UI_SCREEN_WIDTH,self.view.frame.size.height - 64 -memberV.frame.size.height-49)];
    self.tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self initWithTableViewHeaderView];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.allDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThreeProductCell *cell = [ThreeProductCell cellWithTabelView:tableView];
    cell.delegate = self;
    wineCell *winecell = [wineCell cellWithTabelView:tableView];
    NSMutableArray *arr = self.allDataArray[indexPath.section];
    cell.productArray = arr;
    if (indexPath.section == self.allDataArray.count - 1) {
        winecell.wineArray = arr;
        winecell.delegate = self;
        return winecell;
    }
    return cell;
}

#pragma mark  --- 跳转更多产品页面
- (void)moreProductWithProduct:(product *)pro{
    MembersViewController *memVC = [[MembersViewController alloc]init];
    memVC.vendor = pro.vendor;
    [self.navigationController pushViewController:memVC animated:YES];
}

- (void)moreWineProductWithProduct:(product *)pro{
    MembersViewController *memVC = [[MembersViewController alloc]init];
    memVC.vendor = pro.vendor;
    [self.navigationController pushViewController:memVC animated:YES];
}

#pragma mark -- 商品详情代理
- (void)detailProductWithProduct:(product *)product{
    GoodsDetailsController *goodDVC = [[GoodsDetailsController alloc]init];
    goodDVC.pro = product;
    [self.navigationController pushViewController:goodDVC animated:YES];
}

- (void)detailWineProductWithProduct:(product *)product{
    GoodsDetailsController *goodDVC = [[GoodsDetailsController alloc]init];
    goodDVC.pro = product;
    [self.navigationController pushViewController:goodDVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.allDataArray.count-1) {
        return 300;
    }else{
        
        return 230;
    }
}




//设置头视图
- (void)initWithTableViewHeaderView{
    
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = [UserInfo shareUserInfo].token;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:ProductBannerUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *arr = [NSMutableArray array];
        NSMutableArray *urlArr = [NSMutableArray array];
        banner *ad = [banner bannerWithDic:responseObject];
        for (int i = 0; i < ad.imgsArr.count; i++) {
            NSDictionary *dic = ad.imgsArr[i];
            NSString *urlString = dic.allValues[0];
            [urlArr addObject:urlString];
            NSString *str = dic.allKeys[0];
            [arr addObject:str];
        }
        
        bannerScrollView *banS = [bannerScrollView bannerScrollVWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150) array:arr];
#pragma mark -- 点击广告跳转
        banS.tapBlock = ^(NSInteger index){
            ProductBannerVC *bannerVC = [[ProductBannerVC alloc]init];
            bannerVC.BannerUrlStr = urlArr[index];
            [self.navigationController pushViewController: bannerVC animated:YES];
        };
        self.tableView.tableHeaderView = banS;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}





//获取商品列表数据
- (void)getProductData{
    
   
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
   
    param[@"token"] = [UserInfo shareUserInfo].token;


    NSLog(@"当前token = %@   当前时间戳 = %@",[UserInfo shareUserInfo].token,[UserInfo shareUserInfo].timestamp);
    [[ShowHud shareHud] showLoadHud];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:ProductHomeUrl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
#pragma mark -- token 过期 重新登录
//        NSLog(@"%@",responseObject);
//        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"status"] integerValue] == -1) {
            LoginViewController *login = [[LoginViewController alloc]init];
            UINavigationController *loNa = [[UINavigationController alloc]initWithRootViewController:login];
            loNa.navigationBarHidden = YES;
            [self presentViewController:loNa animated:YES completion:nil];
        }else if ([responseObject[@"status"] integerValue] == 1){
            NSDictionary *data = responseObject[@"data"];
            for (NSDictionary *dic in data[@"gift"]) {
                product *pro = [product setupProdtctWithDic:dic];
                
                [self.giftArray addObject:pro];
                if (![self.allDataArray containsObject:self.giftArray]) {
                    [self.allDataArray addObject:self.giftArray];
                }
            }
            for (NSDictionary *oildic in data[@"oil"]) {
                product *pro = [product setupProdtctWithDic:oildic];
                
                [self.oilArray addObject:pro];
                if (![self.allDataArray containsObject:self.oilArray]) {
                    [self.allDataArray addObject:self.oilArray];
                }
            }
            for (NSDictionary *proDic in data[@"package"]) {
                product *pro = [product setupProdtctWithDic:proDic];
                
                [self.productArray addObject:pro];
                if (![self.allDataArray containsObject:self.productArray]) {
                    [self.allDataArray addObject:self.productArray];
                }
            }
            for (NSDictionary *wineDic in data[@"wine"]) {
                product *pro = [product setupProdtctWithDic:wineDic];
                
                [self.wineArray addObject:pro];
                if (![self.allDataArray containsObject:self.wineArray]) {
                    [self.allDataArray addObject:self.wineArray];
                }
            }
            
            [self.tableView reloadData];

        }
        [[ShowHud shareHud] showHide];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [[ShowHud shareHud] showHide];
    }];
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
