//
//  memberView.h
//  BNXComeHere
//
//  Created by  徐智 on 15/12/14.
//  Copyright © 2015年 linyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface memberView : UIView

@property (nonatomic,retain)UILabel *allMember;
@property (nonatomic,retain)UILabel *myMember;
@property (nonatomic,retain)UILabel *surplus;

+ (instancetype)memberViewWithFrame:(CGRect)frame allMember:(NSString *)allMember myMember:(NSString *)myMember surplus:(NSString *)surplus;

- (instancetype)initWithFrame:(CGRect)frame allMember:(NSString *)allMember myMember:(NSString *)myMember surplus:(NSString *)surplus;

@end
