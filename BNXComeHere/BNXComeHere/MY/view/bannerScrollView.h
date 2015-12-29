//
//  bannerScrollView.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/14.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^block)(NSInteger);

@interface bannerScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame array:(NSMutableArray *)array;
+ (instancetype)bannerScrollVWithFrame:(CGRect)frame array:(NSMutableArray *)array;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)NSMutableArray *currentArray;
@property (nonatomic,assign)NSInteger currentpage;
@property (nonatomic,copy)block tapBlock;

@end
