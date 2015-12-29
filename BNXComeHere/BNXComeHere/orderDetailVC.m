//
//  orderDetailVC.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/21.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "OrderFooterView.h"
#import "ProductOorderCell.h"
#import "orderDetailHeaderView.h"
#import "orderDetailVC.h"

@interface orderDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,retain)UITableView *tabView;
@property (nonatomic,retain)orderDetailHeaderView *orderHeaderV;

@end

@implementation orderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
     [self creatNavBar];
    
    [self creatTableView];
    
    
    
}

-(void)creatTableView
{
    self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    orderDetailHeaderView *orHV = [[orderDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 125) order:self.productOrder];
    OrderFooterView *orderFV =[OrderFooterView orderFooterViewWithproductOrder:self.productOrder];
    self.tabView.tableFooterView = orderFV;
    self.tabView.tableHeaderView = orHV;
    float height = [UIScreen mainScreen].bounds.size.height;
    float tabViewH = CGRectGetMaxY(self.tabView.tableFooterView.frame);
    if (height > tabViewH) {
        CGRect frame = orderFV.frame;
        frame.size.height += height - tabViewH;
        orderFV.frame = frame;
    }
//    orderFV.backgroundColor = [UIColor yellowColor];
    
    self.tabView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    orHV.backgroundColor = [UIColor whiteColor];
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productOrder.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductOorderCell *cell = [ProductOorderCell cellWithTabelView:tableView];
    cell.pro = self.productOrder.productArray[indexPath.row];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}



- (void)creatNavBar{
    self.title = @"订单详情";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回键"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

-(void)leftAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
