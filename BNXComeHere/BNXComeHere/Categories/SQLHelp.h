//
//  SQLHelp.h
//  SQLite6_17_14_1
//
//  Created by ibokan on 15/6/17.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SQLHelp : NSObject
//创建对象
{
    sqlite3 *db;//要操作数据库的对象
}

//声明插入的方法
-(BOOL)insert:(NSDictionary*)dic;
//声明一个查询的方法
-(NSMutableArray*)select:(NSString*)goods_id;
//声明一个更新数据的方法
-(BOOL)update:(NSDictionary*)dic;
//声明删除
-(BOOL)del:(NSString*)goods_id;

@end
