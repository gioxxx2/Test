//
//  banner.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/14.
//  Copyright © 2015年 linyj. All rights reserved.
//



#import "banner.h"

@implementation banner

+ (instancetype)bannerWithDic:(NSDictionary *)dic{
    return [[banner alloc]initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
       
       
        
        _timestamp = dic[@"timestamp"];
        _imgsArr = [NSMutableArray array];
        for (NSDictionary *imgDic in dic[@"imgs"]) {
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
#pragma mark -- 配置图片的名字，尺寸，类型
            NSString *imgUrl = imageBanner(imgDic[@"name"], @"s",imgDic[@"postfix"]);
//            NSLog(@"%@",imgUrl);
            NSString *url = imgDic[@"url"];
            
            [dic1 setValue:url forKey:imgUrl];
            [_imgsArr addObject:dic1];
        }
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
