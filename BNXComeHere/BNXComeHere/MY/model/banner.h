//
//  banner.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/14.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface banner : NSObject

@property (nonatomic,retain)NSString *timestamp;
@property (nonatomic,retain)NSMutableArray *imgsArr;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)bannerWithDic:(NSDictionary *)dic;

@end
