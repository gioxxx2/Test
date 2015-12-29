//
//  MyInformationViewController.m
//  BNXComeHere
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 linyj. All rights reserved.
//
#import "MyQRCodeVC.h"
#import "SDImageCache.h"
#import "ShowHud.h"
#import "LoginViewController.h"
#import "GoodsViewController.h"
#import "OrderRecordController.h"
#import "UserInfo.h"
#import "MyInformationViewController.h"
#import "IconCell.h"
#import "AddressChangeViewController.h"
#import "MyPhoneViewController.h"
#import "MyEmialViewController.h"
#import "ChangePswViewController.h"


@interface MyInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIButton * mypicbtn;
    UIImageView * photov;
    
    //图片2进制路径
    NSString* filePath;
    NSData * imageData;
    
}
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSArray *dataArr;
@property (nonatomic,retain)IconCell *iconCell;

@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"个人信息";
 
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    
    self.dataArr = @[@"修改头像",@"推荐二维码",@"修改地址",@"换绑手机",@"绑定邮箱",@"修改密码",@"我的购买记录",@"我的购物车",@"清除缓存"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height-150*autoSizeScaleY)) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
//    self.tableView.backgroundColor = [UIColor yellowColor];
    self.tableView.scrollEnabled = NO;
    UIButton * outbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//     outbtn
    [outbtn setBackgroundImage:[UIImage imageNamed:@"分享按钮@3x.png"] forState:UIControlStateNormal];
    outbtn.center = CGPointMake(self.view.frame.size.width/2, CGRectGetMaxY(self.tableView.frame)+40);
    outbtn.bounds = CGRectMake(0, 0, self.view.frame.size.width*2/3, 40);
    [outbtn addTarget:self action:@selector(outbtnaction) forControlEvents:UIControlEventTouchUpInside];
    [outbtn setTitle:@"退出登录" forState: UIControlStateNormal];
    outbtn.titleLabel.font = [UIFont systemFontOfSize: 18];
    
    [self.view addSubview:outbtn];
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            [self changepicbtn];
        }
            break;
        case 1:{
            [self Btn1action];
        }
            break;
        case 2:{
            [self Btn2action];
        }
            break;
        case 3:{
            [self Btn3action];
        }
            break;
        case 4:{
            [self Btn4action];
        }
            break;
        case 5:{
            [self Btn5action];
        }
            break;
        case 6:{
            OrderRecordController *orderVC = [[OrderRecordController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
        }
            break;
        case 7:{
            GoodsViewController *goodVC = [[GoodsViewController alloc]init];
            [self.navigationController pushViewController:goodVC animated:YES];
        }
            break;
        case 8:{
            [self clearDisk];
        }
            break;
        default:
            break;
    }
}

// 计算缓存
- (NSString *)cacheSize{
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSUInteger kbSize = cache.getSize/1024;
    CGFloat mbSize = kbSize/1024.00;
    NSString *size = nil;
    if (kbSize > 1000) {
        size = [NSString stringWithFormat:@"%.2fMB",mbSize];
    }else{
        size = [NSString stringWithFormat:@"%luKB",(unsigned long)kbSize];
    }
    return size;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cell";
    static NSString *iconS = @"iconCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    IconCell *iconCell = [tableView dequeueReusableCellWithIdentifier:iconS];

   
    if (indexPath.row > 0) {
        if (cell == nil) {
            cell =  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
            
        }
        cell.detailTextLabel.text = nil;
        if (indexPath.row == self.dataArr.count-1 ) {
            cell.detailTextLabel.text = [self cacheSize];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.dataArr[indexPath.row];

    }else{
        if (iconCell == nil) {
            iconCell = [IconCell iconCell];
        }
        self.iconCell = iconCell;
        return iconCell;
    }
    return cell;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 42 *autoSizeScaleY;
    }
    
}



//删除缓存
- (void)clearDisk{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清除缓存？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ([fileManager fileExistsAtPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"]]) {
            [fileManager removeItemAtPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"] error:nil];
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"清除成功";
        [hud show:YES];
        [hud hide:YES afterDelay:1];
        
        [self.tableView reloadData];
        
    }];
    [alert addAction:oneAction];
    UIAlertAction *oneAction11 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:oneAction11];
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.tableView reloadData];
}


//修改头像按钮
-(void)changepicbtn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"打开照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开照相机拍照
        [self takePhoto];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从手机相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开本地相册
        [self LocalPhoto];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
    

    
}





//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else
    {
        
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
}

#pragma mark - 选择一张图片后进入这个编辑方法
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString * type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        //设置image的尺寸。这里
        CGSize imagesize = image.size;
        imagesize.height = 600;
        imagesize.width = 600;
        
        //对图片大小进行压缩
        image = [self imageWithImage:image scaledToSize:imagesize];
        
        if (UIImagePNGRepresentation(image) == nil)
        {
            imageData = UIImageJPEGRepresentation(image, 0.01);
        }
        else
        {
            imageData = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:imageData attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        
        self.iconCell.iconImageView.image = image;
        [UserInfo shareUserInfo].iconFilePath = filePath;
       
        
    }
    
    [self sendImage];
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - 压缩图片尺寸
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


- (UIImage *)getImageByCuttingImage:( UIImage *)image Rect:( CGRect )rect
{
    // 大图 bigImage
    
    // 定义 myImageRect ，截图的区域
    CGRect myImageRect = rect;
    
    UIImage * bigImage= image;
    
    CGImageRef imageRef = bigImage. CGImage ;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect (imageRef, myImageRect);
    
    CGSize size;
    
    size. width = rect. size . width ;
    
    size. height = rect. size . height ;
    
    UIGraphicsBeginImageContext (size);
    
    CGContextRef context = UIGraphicsGetCurrentContext ();
    
    CGContextDrawImage (context, myImageRect, subImageRef);
    
    UIImage * smallImage = [ UIImage imageWithCGImage :subImageRef];
    
    UIGraphicsEndImageContext ();
    
    return smallImage;
    
}






/**
 *  上传图片
 */
-(void)sendImage
{

    AFHTTPRequestOperationManager * manage = [AFHTTPRequestOperationManager manager];
//    NSString * postUrl = [NSString stringWithFormat:@"http://demo.315bnx.com/img-s/index.php?/profile/avatar"];
    
    NSDictionary * parameters = @{@"userId":[UserInfo shareUserInfo].userId,@"token":[UserInfo shareUserInfo].token};
    
    [manage.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manage POST:editIcon parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
         [formData appendPartWithFileURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",filePath]]  name:@"avatar" error:nil];
         
     }
         success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
        
         NSDictionary *dictionary = responseObject[@"data"];
         [[UserInfo shareUserInfo] setUpWithNewDic:dictionary];
         
         [[ShowHud shareHud] showHudWithText:@"头像修改成功"];
     }
         failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         [[ShowHud shareHud] showHudWithText:@"头像修改失败"];
         
     }];

}









//推荐二维码按钮
-(void)Btn1action
{
 
    MyQRCodeVC * myV = [[MyQRCodeVC alloc]init];
    myV.iconImage = self.iconCell.iconImageView.image;
    [self.navigationController pushViewController:myV animated:YES];
    
}




//修改地址按钮
-(void)Btn2action
{
    
    
    AddressChangeViewController * addressV = [[AddressChangeViewController alloc]init];
    [self.navigationController pushViewController:addressV animated:YES];
    
    
}




//换绑手机按钮
-(void)Btn3action
{
  
    
    MyPhoneViewController * myV = [[MyPhoneViewController alloc]init];
    [self.navigationController pushViewController:myV animated:YES];
    
}




//绑定邮箱按钮
-(void)Btn4action
{
    
    
    MyEmialViewController * myV = [[MyEmialViewController alloc]init];
    [self.navigationController pushViewController:myV animated:YES];
    
}



//修改密码按钮
-(void)Btn5action
{
    
    
    ChangePswViewController * myV = [[ChangePswViewController alloc]init];
    [self.navigationController pushViewController:myV animated:YES];
    
}




//退出按钮
-(void)outbtnaction
{
    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *loNa = [[UINavigationController alloc]initWithRootViewController:login];
    loNa.navigationBarHidden = YES;

    [self presentViewController:loNa animated:YES completion:nil];
    
}


//返回按钮
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
