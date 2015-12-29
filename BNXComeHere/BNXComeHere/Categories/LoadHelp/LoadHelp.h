//
//  LoadHelp.h
//  TestSBJSON
//
//  Created by guan song on 15/6/10.
//  Copyright (c) 2015年 guan song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "AlertHelper.h"
//服务器地址
#define URL_SERVER @"http://112.74.105.205/upload/mapi/index.php"
@interface LoadHelp : NSObject


/**
 *声明get请求方法
 *
 *  @param param   请求参数
 *  @param handler 请求解析数据成功回调的代码块
 *  @param fail    请求失败或解析失败回调的代码块
 */
+(void)getLoadDataParam:(NSString *)param and:(void (^)(NSMutableArray *arr)) handler  and:(void (^)(NSError *error))fail;

+(void)getDicLoadDataParam:(NSString *)param and:(void (^)(NSDictionary *dic)) handler  and:(void (^)(NSError *error))fail;



/**
 *声明POST请求方法
 *
 *  @param param   请求参数
 *  @param handler 请求解析数据成功回调的代码块
 *  @param fail    请求失败或解析失败回调的代码块
 */
+(void)postLoadDataParam:(NSString *)param and:(void (^)(NSDictionary *dic)) handler  and:(void (^)(NSError *error))fail;

+(void)showOneSecondsViewTitle:(NSString *)title  andMessage:(NSString*)message;

/**
 *  排序
 *
 *  @param arr    要排序的数组
 *  @param strKey 要排序的关键字（例如商品的价格）
 *  @param isASC  降序：YES,升序：NO
 *
 *  @return 返回排序后的数组
 */
+(NSArray *)sortArr:(NSArray *)arr withNumValueKey:(NSString *)strKey andOrder:(BOOL) isASC;

@end
