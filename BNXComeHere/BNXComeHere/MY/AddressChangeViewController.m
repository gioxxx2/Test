//
//  AddressChangeViewController.m
//  BNXComeHere
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 linyj. All rights reserved.
//
#import "UserInfo.h"
#import "AddressChangeViewController.h"

@interface AddressChangeViewController ()<UIGestureRecognizerDelegate>

@end

@implementation AddressChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
 
    self.title = @"修改地址";

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
   
    
    
    [self loadcitydata];
    
    
    [self creatui];
    [self creatTabView];
    
}


/**
 *  地址选择的 TabView  布局  ＝＝＝   2015－11-10
 *
 */
-(void)creatTabView

{
    //
    //
    backgroundview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    backgroundview.backgroundColor = RGBA(83, 83, 83, 0.5);
    backgroundview.userInteractionEnabled = YES;
    [self.view addSubview:backgroundview];
    
    UIImageView * headview = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*70, 64, UI_SCREEN_WIDTH/640*500, UI_SCREEN_WIDTH/640*70)];
    headview.backgroundColor = RGBA(34, 157, 232, 1);
    headview.userInteractionEnabled = YES;
    [backgroundview addSubview:headview];
    
    
    UILabel * headlab = [[UILabel alloc]init];
    headlab.frame = CGRectMake( UI_SCREEN_WIDTH/640*70, 64, UI_SCREEN_WIDTH/640*500, UI_SCREEN_WIDTH/640*70);
    headlab.text = @"选择省市";
    headlab.font = [UIFont boldSystemFontOfSize:15];
    headlab.textColor = [UIColor whiteColor];
    headlab.textAlignment = NSTextAlignmentCenter;
    headlab.userInteractionEnabled = YES;
    [backgroundview addSubview:headlab];
    
    
    
    //关闭按钮
    UIButton * backbtn = [[UIButton alloc]init];
    backbtn.frame = CGRectMake( UI_SCREEN_WIDTH/640*500, 64 + UI_SCREEN_WIDTH/640*5, UI_SCREEN_WIDTH/640*60, UI_SCREEN_WIDTH/640*60);
    [backbtn setBackgroundImage:[UIImage imageNamed:@"关闭按钮@3x.png"] forState:UIControlStateNormal];
    
    [backbtn addTarget:self action:@selector(backbtnaction) forControlEvents:UIControlEventTouchUpInside];
//    [backbtn setTitle:@"确认绑定" forState: UIControlStateNormal];
//    backbtn.titleLabel.font = [UIFont systemFontOfSize: 18];
    //    [backbtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [backgroundview addSubview:backbtn];
    
    
    
    _TabView = [[UITableView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*70,headview.bottom,UI_SCREEN_WIDTH/640*500,UI_SCREEN_HEIGHT -headview.bottom) style:UITableViewStylePlain];
    _TabView.delegate = self;
    _TabView.dataSource = self;
    _TabView.rowHeight = UI_SCREEN_WIDTH/320 *50;
    _TabView.backgroundColor = [UIColor whiteColor];
//    _TabView.hidden = NO;
    [backgroundview addSubview:_TabView];
    
    
    backgroundview.hidden = YES;
    
    //
}



/**
 *  界面布局  ＝＝＝   2015－11-3
 *
 */
-(void)creatui
{
    //
    //
    
    //选择省市
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , 64 + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*200, UI_SCREEN_WIDTH/640*40);
    lab.text = @"选择省市";
    lab.font = [UIFont boldSystemFontOfSize:15];
    lab.textColor = RGBA(93,93,93,1);
    lab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab];
    
    
    
    
    //选择省市 （ 省的选择显示位置 ）
    provincelab = [[UILabel alloc]init];
    provincelab.frame = CGRectMake( lab.right + UI_SCREEN_WIDTH/640*10 , 64 + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*370, UI_SCREEN_WIDTH/640*40);
    if ([UserInfo shareUserInfo].province) {
        provincelab.text = [UserInfo shareUserInfo].province;
        for (NSDictionary *dic12 in province) {
            if ([[UserInfo shareUserInfo].province isEqualToString:dic12[@"lable"]]) {
                city = dic12[@"cities"];
            }
        }
        
    }else{
        provincelab.text = @"请选择省市";
    }
    
    provincelab.font = [UIFont boldSystemFontOfSize:15];
    provincelab.textColor = RGBA(187,186,194,1);
    provincelab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:provincelab];
    
    
    
    
    UIButton * provinceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    provinceBtn.frame = CGRectMake(UI_SCREEN_WIDTH/640*30 , 64, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*90);
    provinceBtn.backgroundColor = [UIColor clearColor];
    [provinceBtn addTarget:self action:@selector(provinceBtnaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:provinceBtn];
    
    
    
    
    //4条线   第1条
    UIImageView * line1 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, 64 + UI_SCREEN_WIDTH/640*90, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*2)];
    line1.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [self.view addSubview:line1];
    
    
    //选择城市
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , line1.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*200, UI_SCREEN_WIDTH/640*40);
    lab1.text = @"选择城市";
    lab1.font = [UIFont boldSystemFontOfSize:15];
    lab1.textColor = RGBA(93,93,93,1);
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab1];
    
    
    
    //选择城市 （ 城市的选择显示位置 ）
    citylab = [[UILabel alloc]init];
    citylab.frame = CGRectMake( lab1.right + UI_SCREEN_WIDTH/640*10 , line1.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*370, UI_SCREEN_WIDTH/640*40);
    if ([UserInfo shareUserInfo].city) {
   
        citylab.text = [UserInfo shareUserInfo].city;
        for (NSDictionary *dic11 in province) {
            if ([[UserInfo shareUserInfo].province isEqualToString:dic11[@"lable"]]) {
                city = dic11[@"cities"];
                for (NSDictionary *countyDic in city) {
                    if ([[UserInfo shareUserInfo].city isEqualToString:countyDic[@"lable" ]]) {
                        district = countyDic[@"counties"];
                    }
                }
            }
        }
        
    }else{
        citylab.text = @"请选择城市";
    }
  
    citylab.font = [UIFont boldSystemFontOfSize:15];
    citylab.textColor = RGBA(187,186,194,1);
    citylab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:citylab];
    
    
    
    
    
    UIButton * cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cityBtn.frame = CGRectMake(UI_SCREEN_WIDTH/640*30 , line1.bottom, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*90);
    cityBtn.backgroundColor = [UIColor clearColor];
    [cityBtn addTarget:self action:@selector(cityBtnaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cityBtn];
    
    
    

    
    
    
    //4条线   第2条
    UIImageView * line2 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, line1.bottom + UI_SCREEN_WIDTH/640*90, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*2)];
    line2.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [self.view addSubview:line2];
    
    
    
    //选择区/县
    UILabel * lab2 = [[UILabel alloc]init];
    lab2.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , line2.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*200, UI_SCREEN_WIDTH/640*40);
    lab2.text = @"选择区/县";
    lab2.font = [UIFont boldSystemFontOfSize:15];
    lab2.textColor = RGBA(93,93,93,1);
    lab2.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab2];
    
    
    
    //选择区/县 （ 区/县的选择显示位置 ）
    countylab = [[UILabel alloc]init];
    countylab.frame = CGRectMake( lab1.right + UI_SCREEN_WIDTH/640*10 , line2.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*370, UI_SCREEN_WIDTH/640*40);
    if ([UserInfo shareUserInfo].county) {
        countylab.text = [UserInfo shareUserInfo].county;
    }else{
        countylab.text = @"请选择区/县";
    }
   
    countylab.font = [UIFont boldSystemFontOfSize:15];
    countylab.textColor = RGBA(187,186,194,1);
    countylab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:countylab];
    
    
    
    UIButton * countyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    countyBtn.frame = CGRectMake(UI_SCREEN_WIDTH/640*30 , line2.bottom, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*90);
    countyBtn.backgroundColor = [UIColor clearColor];
    [countyBtn addTarget:self action:@selector(countyBtnaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:countyBtn];
    
    
    
    //4条线   第3条
    UIImageView * line3 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, line2.bottom + UI_SCREEN_WIDTH/640*90, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*2)];
    line3.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [self.view addSubview:line3];
    
    
    
    //详细地址
    UILabel * lab3 = [[UILabel alloc]init];
    lab3.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , line3.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*200, UI_SCREEN_WIDTH/640*40);
    lab3.text = @"详细地址";
    lab3.font = [UIFont boldSystemFontOfSize:15];
    lab3.textColor = RGBA(93,93,93,1);
    lab3.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab3];
    
    
    
    
    //选择具体地址 （ 选择具体地址的显示位置 ）
    _myaddress = [[UITextField alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30 , line3.bottom + UI_SCREEN_WIDTH/640*65, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*40)];
    //    _userTf.leftView = userImgView;
    _myaddress.leftViewMode = UITextFieldViewModeAlways;
    _myaddress.textAlignment = NSTextAlignmentRight;
    _myaddress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _myaddress.keyboardType = UIKeyboardAppearanceDefault;
    if ([UserInfo shareUserInfo].address) {
        _myaddress.placeholder = [UserInfo shareUserInfo].address;
    }else{
        _myaddress.placeholder = @"请输入街道、路、门牌等信息";
    }
    
    
    _myaddress.textColor = RGBA(187,186,194,1);
    _myaddress.font = [UIFont boldSystemFontOfSize:15];
    _myaddress.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _userTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [self.view addSubview:_myaddress];
    
    
    
    
    
    //4条线   第4条
    UIImageView * line4 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, line3.bottom + UI_SCREEN_WIDTH/640*130, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*2)];
    line4.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [self.view addSubview:line4];
    
    
    
    
    //详细地址
    UILabel * lab4 = [[UILabel alloc]init];
    lab4.frame = CGRectMake( UI_SCREEN_WIDTH/640*30 , line4.bottom + UI_SCREEN_WIDTH/640*25, UI_SCREEN_WIDTH/640*200, UI_SCREEN_WIDTH/640*40);
   
    lab4.text = @"收货人";
    lab4.font = [UIFont boldSystemFontOfSize:15];
    lab4.textColor = RGBA(93,93,93,1);
    lab4.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab4];
    
    
    
    
    //填写收货人信息 （ 填写收货人信息的显示位置 ）
    _myname = [[UITextField alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30 , line4.bottom + UI_SCREEN_WIDTH/640*65, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*40)];
    //    _userTf.leftView = userImgView;
    _myname.leftViewMode = UITextFieldViewModeAlways;
    _myname.textAlignment = NSTextAlignmentRight;
    _myname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _myname.keyboardType = UIKeyboardAppearanceDefault;
    if ([UserInfo shareUserInfo].receiveMan) {
        _myname.placeholder = [UserInfo shareUserInfo].receiveMan;
    }else{
        _myname.placeholder = @"请填写收货人名字";
    }
    
    _myname.textColor = RGBA(187,186,194,1);
    _myname.font = [UIFont boldSystemFontOfSize:15];
    _myname.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    //    _userTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERName]?[[NSUserDefaults standardUserDefaults] objectForKey:USERName]:nil;
    [self.view addSubview:_myname];
    
    
    
    
    
    //4条线   第5条
    UIImageView * line5 = [[UIImageView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH/640*30, line4.bottom + UI_SCREEN_WIDTH/640*130, UI_SCREEN_WIDTH/640*580, UI_SCREEN_WIDTH/640*2)];
    line5.backgroundColor = RGBA(236,236,236,1);
    //    myview1.userInteractionEnabled = YES;
    [self.view addSubview:line5];
    
    
    
    

    //确认按钮
    UIButton * surebtn = [[UIButton alloc]init];
    surebtn.frame = CGRectMake( UI_SCREEN_WIDTH/640*120, line5.bottom + UI_SCREEN_WIDTH/640*50, UI_SCREEN_WIDTH/640*400, UI_SCREEN_WIDTH/640*70);
    [surebtn setBackgroundImage:[UIImage imageNamed:@"我的-信息-修改地址-确认修改按钮@3x.png"] forState:UIControlStateNormal];
    
    [surebtn addTarget:self action:@selector(surebtnaction) forControlEvents:UIControlEventTouchUpInside];
    [surebtn setTitle:@"确认修改" forState: UIControlStateNormal];
    surebtn.titleLabel.font = [UIFont systemFontOfSize: 18];
    //    [surebtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [self.view addSubview:surebtn];
    

    
    
    
    
    
    //
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


//    “选择省”  的点击事件
-(void)provinceBtnaction
{
     [self.view endEditing:YES];
    ttype = @"1";

    
    backgroundview.hidden = NO;
    [_TabView reloadData];
    
}




//    “选择市”  的点击事件
-(void)cityBtnaction
{
     [self.view endEditing:YES];
    if ([provincelab.text isEqualToString:@"请选择省市"])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请先选择省市!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }
    else
    {
        ttype = @"2";
        backgroundview.hidden = NO;
        [_TabView reloadData];
        
    }

    

}




//    “选择区”  的点击事件
-(void)countyBtnaction
{
    [self.view endEditing:YES];
    if ([provincelab.text isEqualToString:@"请选择省市"])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请先选择省市!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }
    else if ([citylab.text isEqualToString:@"请选择城市"])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请先选择城市!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }else
    {
        ttype = @"3";
        backgroundview.hidden = NO;
        [_TabView reloadData];
    }

}





//“确认更改按钮”点击事件
-(void)surebtnaction
{
    
    
    
    [self.view endEditing:YES];
    if ([provincelab.text isEqualToString:@"请选择省市"])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请先选择省市!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }
    else if ([citylab.text isEqualToString:@"请选择城市"])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请先选择城市!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }
    else if ([countylab.text isEqualToString:@"请选择区/县"])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请先选择区/县!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }
    else if ([_myaddress.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请填写详细地址!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }
    else if ([_myname.text isEqualToString:@""])
    {
        SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请填写收货人名字!"];
        [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
         {
         }];
        [alertView show];
        
    }else
    {
        NSDictionary *dict = @{@"userId":[UserInfo shareUserInfo].userId,@"token":[UserInfo shareUserInfo].token,@"province":provincelab.text,@"city":citylab.text,@"county":countylab.text,@"address":_myaddress.text,@"receiveMan":_myname.text};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
//        NSString *urlPath = [[NSString alloc] initWithFormat:@"%@member/user/app/address/update?",demoAddress];
       
        
        [manager POST:editAddressUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {

            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"status"]intValue]==1) {



                NSDictionary *dictionary = responseObject[@"data"];

                UserInfo *info = [UserInfo shareUserInfo];
                info.city = dictionary[@"city"];
                info.county = dictionary[@"county"];
                info.province = dictionary[@"province"];
                info.address = dictionary[@"address"];
                info.receiveMan = dictionary[@"receiveMan"];
               
                [[ShowHud shareHud] showHudWithText:@"地址修改成功"];
                
                
              
                
                
            }else{
                //登入失败提示消息
                [[ShowHud shareHud] showErrorWithinfo:responseObject[@"errorCode"] controller:self];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
            SIAlertView *alertView = [SIAlertView normalAlertViewWithMessage:@"请求失败!"];
            [alertView addOKButtonWithHandler:^(SIAlertView *alertView)
             {
             }];
            [alertView show];
        }];
        
        
        
        
    }

    
}





#pragma mark UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    long k = 0.00;
    
    if ([ttype isEqualToString:@"1"]) {
        
        k = province.count;
        
    }else if([ttype isEqualToString:@"2"])
    {
        k = city.count;
        
    }else if([ttype isEqualToString:@"3"])
    {
        k = district.count;
    }
    return k;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    if ([ttype isEqualToString:@"1"]) {
        
        NSString * str = [province[indexPath.row] objectForKey:@"lable"];
        cell.textLabel.text = str;
        
    }else if([ttype isEqualToString:@"2"])
    {
        NSString * str = [city[indexPath.row] objectForKey:@"lable"];
        cell.textLabel.text = str;
        
    }else if([ttype isEqualToString:@"3"])
    {
        NSString * str = [NSString stringWithFormat:@"%@",district[indexPath.row]];
        cell.textLabel.text = str;
    }
    
    
    
    
    return cell;
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if ([ttype isEqualToString:@"1"]) {
        
        
        NSString *selected = [province[indexPath.row] objectForKey:@"lable"];
        
        city = [province[indexPath.row] objectForKey:@"cities"];
        

        citylab.text = @"请选择城市";
        countylab.text = @"请选择区/县";
        provincelab.text = selected;
        
        
    }else if([ttype isEqualToString:@"2"])
    {
        NSString *selectedCity = [city[indexPath.row] objectForKey:@"lable"];
        
        district = [city[indexPath.row] objectForKey:@"counties"];
 
        countylab.text = @"请选择区/县";

        citylab.text = selectedCity;
        
    }else if([ttype isEqualToString:@"3"])
    {
//        NSString *selectedCity = [district objectAtIndex: indexPath.row];
        
         NSString * selectedCity = [NSString stringWithFormat:@"%@",district[indexPath.row]];
        
        countylab.text = selectedCity;
        
    }
    
    

    
    
    
    backgroundview.hidden = YES;

    
    

}




//＊＊＊＊＊＊＊   城市数据解析事件（  2015.11.11   ）
- (void)loadcitydata
{
    //
    //
    //
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityTree" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    
//    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    province =  [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
   

    
//    NSString * lll = [province[2] objectForKey:@"lable"];
//    city = [province[2] objectForKey:@"cities"];
//    district = [city[0] objectForKey:@"counties"];
//
//    
//    NSString * lll1 = [NSString stringWithFormat:@"%@",district[0]];
//    NSString * lll2 = [NSString stringWithFormat:@"%@",district[1]];
//    NSString * lll3 = [NSString stringWithFormat:@"%@",district[2]];
    
    

    
    
    
}


-(void)backbtnaction
{
    //
    //
    backgroundview.hidden = YES;
    //
}



-(void)goback
{
    //
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
