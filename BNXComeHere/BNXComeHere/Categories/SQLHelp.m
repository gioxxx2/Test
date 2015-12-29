//
//  SQLHelp.m
//  SQLite6_17_14_1
//
//  Created by ibokan on 15/6/17.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "SQLHelp.h"

@implementation SQLHelp

/**
 *  获取沙盒地址
 *
 *  @return 沙盒地址
 */
-(NSString*)getFilePath
{
    //获取document路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取第0个地址
    NSString *path=paths[0];
    //获取数据库地址，拼接数据库名称
    NSString *filePath=[path stringByAppendingString:@"/Goods.sqlite"];
    NSLog(@"%@",filePath);
    //创建文件管理器
    NSFileManager *manger=[NSFileManager defaultManager];
    //判断数据库存在？
    if (![manger fileExistsAtPath:filePath])
    {
        //若文件不存在就复制
        NSString *fileSqlPath=[[NSBundle mainBundle]pathForResource:@"Goods" ofType:@"sqlite"];
        NSError *err=nil;
        //执行文件复制
        [manger copyItemAtPath:fileSqlPath toPath:filePath error:&err];
        if (err!=nil)
        {
            NSLog(@"%@",err);
            return nil;
        }
    }
    NSLog(@"%@",filePath);
    return filePath;
}

/**
 *  打开数据库的方法
 *
 *  @return 打开结果
 */
-(BOOL)openDB
{
    NSString *path=[self getFilePath];//获取数据库地址
    //打开数据库
    int rst=sqlite3_open([path UTF8String], &db);
    
    if (rst==SQLITE_OK)//打开成功
    {
        NSLog(@"打开成功！");
        return YES;
    }
    else//打开失败
    {
        //先关闭数据库
        [self closeDB];
        NSLog(@"打开失败！");
        return NO;
    }
}

/**
 *  关闭数据库
 */
-(void)closeDB
{
    //关闭数据库
    sqlite3_close(db);
}


-(BOOL)insert:(NSDictionary *)dic
{
    //打开数据库
    BOOL ret=[self openDB];
    if (ret)//打开了
    {
        //创建插入语句
        NSString *sql=[NSString stringWithFormat:@"insert into 'goodsListTable' ('goods_id','title','image','cur_price') values('%@','%@','%@','%@')",dic[@"goods_id"],dic[@"title"],dic[@"image"],dic[@"cur_price"]];
        NSLog(@"%@",sql);
        //创建一个存放插入错误信息的变量
        char *err;
        //执行
        int result=sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err);
        if (result==SQLITE_OK)
        {
            NSLog(@"插入成功！");
            //关闭数据库
            [self closeDB];
            return YES;
        }
        else
        {
            NSLog(@"插入失败！%s",err);
            //关闭数据库
            [self closeDB];
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

-(NSMutableArray*)select:(NSString*)goods_id
{
    //打开数据库
    BOOL rst=[self openDB];
    if (rst)
    {
        //初始化数组
        NSMutableArray *arr=[NSMutableArray new];
        //创建sql语句
        NSString *sql;
        if (goods_id==nil)
        {
            sql=@"select *from 'goodsListTable'";//查全部
        }
        else
        {
            sql=[NSString stringWithFormat:@"select *from 'goodsListTable' where goods_id=%@",goods_id];//根据商品id查询
        }
        
        NSLog(@"%@",sql);
        //创建返回来的结果对象
        sqlite3_stmt *statement;
        //执行sql语句
        
        int result=sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
        if (result==SQLITE_OK)
        {
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                //拿出第0列（int）
                int goods_id=sqlite3_column_int(statement, 0);
                //拿出第1列
                char *title=(char *)sqlite3_column_text(statement, 1);
                //拿出第2列
                char *image=(char *)sqlite3_column_text(statement, 2);
                //拿出第3列
                char *cur_price=(char *)sqlite3_column_text(statement, 3);
                
                //转换数据类型为字符串，才能存放到字典里面
                NSString *str_goods_id=[NSString stringWithFormat:@"%d",goods_id];
                NSString *str_title=[NSString stringWithUTF8String:title];
                NSString *str_image=[NSString stringWithUTF8String:image];
                NSString *str_cur_price=[NSString stringWithUTF8String:cur_price];
                
                NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:str_goods_id,@"goods_id",str_title,@"title",str_image,@"image",str_cur_price,@"cur_price", nil];
                //加入数组
                [arr addObject:dic];
            }
            NSLog(@"查询成功");
            //关闭数据库
            [self closeDB];
            return  arr;
        }
        else
        {
            [self closeDB];
            NSLog(@"查询失败");
            return  nil;
        }
    }
    else
    {
        NSLog(@"打开数据库失败");
        return nil;
    }
}

-(BOOL)update:(NSDictionary *)dic
{
    //先去查找
    NSMutableArray *arr=[self select:dic[@"goods_id"]];
    //判断能不能找到要修改的商品
    if(arr.count<1)
    {
        NSLog(@"不存在修改的对象");
        return NO;
    }
    else
    {
        //打开数据库
        BOOL rst=[self openDB];
        if (rst)
        {
            //创建sql语句
            NSString *sql=[NSString stringWithFormat:@"update 'goodsListTable' set 'title'='%@','image'='%@','cur_price'='%@' where goods_id%@",dic[@"title"],dic[@"image"],dic[@"cur_price"],dic[@"goods_id"]];
            NSLog(@"%@",sql);
            //创建存储错误信息的变量
            char *err=nil;
            int result=sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err);
            //判断结果
            if (result!=SQLITE_OK)
            {
                [self closeDB];
                NSLog(@"更新失败%s",err);
                return NO;
            }
            else
            {
                NSLog(@"修改成功");
                [self closeDB];
                return YES;
            }
        }
        else
        {
            NSLog(@"打开失败！");
            return NO;
        }
    }
}

-(BOOL)del:(NSString *)goods_id
{
    NSMutableArray *arr=[self select:goods_id];
    if (arr.count<1)
    {
        NSLog(@"没有要删除的对象");
        return NO;
    }
    else
    {
        //创建sql语句
        NSString *sql=[NSString stringWithFormat:@"delete from 'goodsListTable' where goods_id=%@",goods_id];
        char *err;
        int rst=sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err);
        if (rst==SQLITE_OK)
        {
            NSLog(@"删除成功");
            [self closeDB];
            return YES;
        }
        else
        {
            NSLog(@"删除失败");
            [self closeDB];
            return NO;
        }
    }
    
}

@end
