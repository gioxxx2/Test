//
//  OrderRecordController.m
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//
#import "orderProNameL.h"
#import "orderDetailVC.h"
#import "orderCell.h"
#import "productOrder.h"
#import "OrderRecordController.h"
#import "OrderRecordViewCell.h"
#import "AFNetworking.h"
#define GetHeight [UIScreen mainScreen].bounds.size.height //获取屏幕高度
#define GetWidth [UIScreen mainScreen].bounds.size.width  //获取屏幕宽度
@interface OrderRecordController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property(strong, nonatomic) UITableView * tabView;
@property(strong, nonatomic) NSMutableArray * arrData;
@property(strong, nonatomic) NSDictionary * tempDic;
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,assign)CGFloat cellH;
@property (nonatomic,assign)BOOL isGetData;
@end

@implementation OrderRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.count = 1;
    [self loadSourceWithCount:self.count];
    [self creatNavBar];
    [self creatTableView];
  
    
}

- (void)creatNavBar{
    self.title = @"订单记录";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回键"] style:UIBarButtonItemStylePlain target:self action:@selector(recoredPop)];

    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

-(void)recoredPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark*********数据下载**************
-(void)loadSourceWithCount:(NSInteger)count
{
    
    
    NSMutableDictionary *parama = [NSMutableDictionary dictionary];
    
    parama[@"token"] = [UserInfo shareUserInfo].token;
    parama[@"userId"] = [UserInfo shareUserInfo].userId;
    parama[@"pageNo"] = [NSString stringWithFormat:@"%ld",count];
    [[ShowHud shareHud] showLoadHud];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:historyProductUrl parameters:parama success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        _tempDic = [responseObject objectForKey:@"data"];
        NSArray *orderS = [_tempDic objectForKey:@"orders"];
        if (orderS.count == 0) {
            
            self.tabView.hidden = YES;
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 173, 30)];
            lab.text = @"您目前没有购买记录";
            lab.center = self.view.center;
            lab.font = [UIFont systemFontOfSize:19.0f];
            [self.view addSubview:lab];
        }else{
            for (NSDictionary * dic in orderS) {
                productOrder *proOrder = [productOrder setUpOrderWithDic:dic];
                
                [self.arrData addObject:proOrder];
            }
            
            [self.tabView reloadData];
        }
        
       
        [[ShowHud shareHud] showHide];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [[ShowHud shareHud] showHide];
    }];

}

#pragma mark********创建tabview*************
-(void)creatTableView
{
    self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, GetWidth, GetHeight) style:UITableViewStylePlain];
    self.tabView.delegate = self;
    self.tabView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.tabView.dataSource = self;
    self.tabView.tableFooterView = [[UIView alloc]init];
   // self.tabView.backgroundColor = [UIColor clearColor];
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabView];
}
//delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderCell *cell = [orderCell cellWithTabelView:tableView];
    
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[orderProNameL class]]) {
            [subview removeFromSuperview];
        }
    }
    
    cell.proOrder = self.arrData[indexPath.row];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  orderCell *cell =   (orderCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"cellHeight_________%.f",cell.cellHeight);
    return  cell.cellHeight+10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    orderDetailVC *orderVC = [[orderDetailVC alloc]init];
    orderVC.productOrder = self.arrData[indexPath.row];
    [self.navigationController pushViewController:orderVC animated:YES   ];
}

-(NSMutableArray *)arrData
{
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
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
