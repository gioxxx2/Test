//
//  GoodsInfo.m
//  BNXComeHere
//
//  Created by 陈华军 on 15/11/19.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import "GoodsInfo.h"

@implementation GoodsInfo
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_goodsName forKey:@"productName"];
    [aCoder encodeObject:_goodsPrice forKey:@"memberPrice"];
    [aCoder encodeInteger:_goodsCount forKey:@"count"];
    [aCoder encodeObject:_goodsImage forKey:@"pics"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _goodsName = [aDecoder decodeObjectForKey:@"productName"];
        _goodsPrice = [aDecoder decodeObjectForKey:@"memberPrice"];
        _goodsCount = [aDecoder decodeIntForKey:@"count"];
        _goodsImage = [aDecoder decodeObjectForKey:@"pics"];
    }
    return self;
}
@end
