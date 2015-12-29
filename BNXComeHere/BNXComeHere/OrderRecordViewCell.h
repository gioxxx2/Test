//
//  OrderRecordViewCell.h
//  BNXTwo
//
//  Created by 陈华军 on 15/10/27.
//  Copyright © 2015年 陈华军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderRecordViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNun;//订单编号
@property (weak, nonatomic) IBOutlet UILabel *labName;//商品简介
@property (weak, nonatomic) IBOutlet UILabel *orderData;//订单日期
@property (weak, nonatomic) IBOutlet UILabel *labsize;//尺码
@property (weak, nonatomic) IBOutlet UILabel *labColor;//颜色
@property (weak, nonatomic) IBOutlet UILabel *labCount;//数量
@property (weak, nonatomic) IBOutlet UILabel *labAllPrice;//总价格
@property (weak, nonatomic) IBOutlet UILabel *labPrice;//单价
@property (weak, nonatomic) IBOutlet UIImageView *imageGood;//图片

-(void)setCell:(NSDictionary*)dic;
+(OrderRecordViewCell*)newCell;
@end
