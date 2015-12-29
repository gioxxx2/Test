//
//  LoadHelp.m
//  TestSBJSON
//
//  Created by guan song on 15/6/10.
//  Copyright (c) 2015年 guan song. All rights reserved.
//

#import "LoadHelp.h"

@implementation LoadHelp


+(void)getDicLoadDataParam:(NSString *)param and:(void (^)(NSDictionary *dic)) handler  and:(void (^)(NSError *error))fail
{
    //创建url
    NSURL *url=[NSURL  URLWithString:[NSString stringWithFormat:@"%@?%@",URL_SERVER,param]];
    //创建请求对象
    NSURLRequest *req=[NSURLRequest  requestWithURL:url];
    //发送请求连接
    [NSURLConnection  sendAsynchronousRequest:req queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError==nil)//请求成功
        {
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
            if (connectionError==nil)//解析成功
            {
                //使用GCD在主线程回调代码块
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(dic);
                });
            }
            else//解析失败
            {
                //使用GCD在主线程回调代码块
                dispatch_async(dispatch_get_main_queue(), ^{
                    fail(connectionError);
                });
                
            }
        }
        else//请求失败
        {
            //使用GCD在主线程回调代码块
            dispatch_async(dispatch_get_main_queue(), ^{
                fail(connectionError);
            });
        }
    }];

}



/**
 *实现get请求方法
 *
 *  @param param   请求参数
 *  @param handler 请求解析数据成功回调的代码块
 *  @param fail    请求失败或解析失败回调的代码块
 */
+(void)getLoadDataParam:(NSString *)param and:(void (^)(NSMutableArray *))handler  and:(void (^)(NSError *))fail
{
    //创建url
    NSURL *url=[NSURL  URLWithString:[NSString stringWithFormat:@"%@?%@",URL_SERVER,param]];
    //创建请求对象
    NSURLRequest *req=[NSURLRequest  requestWithURL:url];
    //发送请求连接
    [NSURLConnection  sendAsynchronousRequest:req queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError==nil)//请求成功
        {
            NSMutableArray *arr=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
            if (connectionError==nil)//解析成功
            {
                //使用GCD在主线程回调代码块
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(arr);
                });
            }
            else//解析失败
            {
                //使用GCD在主线程回调代码块
                dispatch_async(dispatch_get_main_queue(), ^{
                    fail(connectionError);
                });
                
            }
        }
        else//请求失败
        {
            //使用GCD在主线程回调代码块
            dispatch_async(dispatch_get_main_queue(), ^{
                fail(connectionError);
            });
        }
    }];
    
}
/**
 *实现POST请求方法
 *
 *  @param param   请求参数
 *  @param handler 请求解析数据成功回调的代码块
 *  @param fail    请求失败或解析失败回调的代码块
 */
+(void)postLoadDataParam:(NSString *)param and:(void (^)(NSDictionary *))handler and:(void (^)(NSError *))fail
{
    //创建url
    NSURL *url=[NSURL URLWithString:[NSString  stringWithFormat:@"%@",URL_SERVER]];
    //创建请求对象：参数：url,若有缓存先从缓存取，超时10s发送请求失败
    NSMutableURLRequest *mReq=[NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    //设置body参数
    [mReq  setHTTPBody:[param  dataUsingEncoding:NSUTF8StringEncoding]];
    //设置请求方式
    [mReq  setHTTPMethod:@"POST"];
    //发送异步请求
    [NSURLConnection  sendAsynchronousRequest:mReq queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError==nil)//请求成功
        {
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];//json解析
            if (connectionError==nil)//解析成功
            {
                //使用GCD在主线程回调代码块
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(dic);
                });
            }
            else//解析失败
            {
                //使用GCD在主线程回调代码块
                dispatch_async(dispatch_get_main_queue(), ^{
                     fail(connectionError);
                });
              
            }
        }
        else//请求失败
        {
            //使用GCD在主线程回调代码块
            dispatch_async(dispatch_get_main_queue(), ^{
                fail(connectionError);
            });
        }
        
    }];
    
    
    
    
    
    
}

+(void)showOneSecondsViewTitle:(NSString *)title andMessage:(NSString *)message
{
    UIAlertView *alert=[[UIAlertView  alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
}

/**
 *  排序
 *
 *  @param arr    要排序的数组
 *  @param strKey 要排序的关键字（例如商品的价格）
 *  @param isASC  降序：YES,升序：NO
 *
 *  @return 返回排序后的数组
 */
+(NSArray *)sortArr:(NSArray *)arr withNumValueKey:(NSString *)strKey andOrder:(BOOL) isASC
{
    NSArray * arrResult =  [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
                            {
                                if([obj1[strKey] intValue]<[obj2[strKey] intValue])
                                {
                                    if (isASC)
                                    {
                                        return NSOrderedDescending;
                                    }
                                    else
                                    {
                                        return  NSOrderedAscending;
                                    }
                                    
                                }
                                if ([obj1[strKey] intValue]>[obj2[strKey] intValue])
                                {
                                    if (isASC)
                                    {
                                        return NSOrderedAscending;
                                        
                                    }
                                    else
                                    {
                                        return NSOrderedDescending;
                                    }
                                }
                                return NSOrderedSame;
                            }];
    return arrResult;
}

@end
