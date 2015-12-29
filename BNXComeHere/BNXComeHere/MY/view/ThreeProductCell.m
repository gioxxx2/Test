//
//  ThreeProductCell.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/15.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "product.h"
#import "ThreeProductCell.h"


@interface ThreeProductCell ()

@property (nonatomic,retain)UIView *blueView;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UIView *lineView;
@property (nonatomic,retain)UIButton *moreBtn;
@property (nonatomic,retain)NSMutableArray *subTitleArray;
@property (nonatomic,retain)NSMutableArray *imageSArray;
@property (nonatomic,retain)NSMutableArray *proArray;
@end

@implementation ThreeProductCell

- (NSMutableArray *)proArray{
    if (!_proArray) {
        _proArray = [NSMutableArray array];
    }
    return _proArray;
}

- (NSMutableArray *)imageSArray{
    if (!_imageSArray) {
        _imageSArray = [NSMutableArray array];
    }
    return _imageSArray;
}

- (NSMutableArray *)subTitleArray{
    if (!_subTitleArray) {
        _subTitleArray = [NSMutableArray array];
    }
    return _subTitleArray;
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView{
    static NSString *ID = @"product";
    ThreeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ThreeProductCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f];
        
        self.blueView = view;
        [self.contentView addSubview:self.blueView];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
//        self.titleLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.lineView];
        
        self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [self.moreBtn setTitleColor:[UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f] forState:UIControlStateNormal];
        self.moreBtn.layer.cornerRadius = 5;
        self.moreBtn.layer.borderWidth = 1;
        self.moreBtn.layer.borderColor = [UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f].CGColor;
        self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.moreBtn];
        
        
        for (int i = 0; i < 3; i++) {
            UIImageView *imageV = [[UIImageView alloc]init];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            [imageV addGestureRecognizer:tap];
            imageV.tag = i + 5466;
            imageV.contentMode = UIViewContentModeScaleAspectFill;
            imageV.clipsToBounds = YES;
//            imageV.backgroundColor = [UIColor redColor];
            UILabel *titleL = [[UILabel alloc]init];
            titleL.textAlignment = NSTextAlignmentCenter;

            titleL.font = [UIFont boldSystemFontOfSize:13];
            [self.contentView addSubview:titleL];
            [self.subTitleArray addObject:titleL];
            [self.contentView addSubview:imageV];
            [self.imageSArray addObject:imageV];
        }
        
        
        
    }
    return self;
}

- (void)more{
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreProductWithProduct:)]) {
        if (self.proArray.count > 0) {
            [self.delegate moreProductWithProduct:self.proArray[0]];
        }
    }
}

- (void)tap:(UITapGestureRecognizer *)tap{
    if (self.proArray.count >0) {
        product *pro = self.proArray[tap.view.tag-5466];
        if (self.delegate && [self.delegate respondsToSelector:@selector(detailProductWithProduct:)]) {
            [self.delegate detailProductWithProduct:pro];
        }
    }
}




- (void)setProductArray:(NSMutableArray *)productArray{
    _productArray = productArray;
    unsigned long count = productArray.count;
    for (int i = 0; i < count; i++) {
        product *pro = productArray[i];
        if ([pro.vendor isEqualToString:@"gift"]) {
            self.titleLabel.text = @"精品赠送";
        }else if ([pro.vendor isEqualToString:@"oil"]){
            self.titleLabel.text = @"放心粮油";
        }else if([pro.vendor isEqualToString:@"package"]){
           
            self.titleLabel.text = @"特惠专区";
        }
        if (i <= 2) {
            UILabel *titleL = self.subTitleArray[i];
            titleL.text = pro.productName;
            [self.proArray addObject:pro];
            if (pro.pics.count > 0) {
//                NSString *urlS = [NSString stringWithFormat:demoMiddlegUrl,pro.vendor,pro.pics[0]];
                NSString *urlS = imageProduct(pro.vendor, pro.pics[0], @"m");
                
                UIImageView *imageV = self.imageSArray[i];
                imageV.userInteractionEnabled = YES;
                [imageV sd_setImageWithURL:[NSURL URLWithString:urlS] placeholderImage:[UIImage imageNamed:@"ugc-photo"]];
            }
            
        }else{
            break;
        }
        
    }
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.blueView.frame = CGRectMake(15, 5, 3, 15);
    CGFloat maxX = CGRectGetMaxX(self.blueView.frame);
    self.titleLabel.frame = CGRectMake(maxX+10, 2, self.contentView.frame.size.width-(maxX+10), 25);
    int border = 15*autoSizeScaleX;
    int width = (self.contentView.frame.size.width-4*border)/3;
    for (int i = 0;i < self.subTitleArray.count ; i++) {
        UIImageView *imageV = self.imageSArray[i];
        imageV.frame = CGRectMake(border+i*(width+border), CGRectGetMaxY(self.blueView.frame)+10, width, 110);
        UILabel *subTitleL = self.subTitleArray[i];
        subTitleL.frame = CGRectMake(imageV.frame.origin.x, CGRectGetMaxY(imageV.frame), CGRectGetWidth(imageV.frame), 25);
    }
    UILabel *label = self.subTitleArray[0];
    self.lineView.frame = CGRectMake(20, CGRectGetMaxY(label.frame)+10, self.contentView.frame.size.width-40, 1);
    self.moreBtn.center = CGPointMake(self.contentView.frame.size.width/2, CGRectGetMaxY(self.lineView.frame)+25*autoSizeScaleY);
    self.moreBtn.bounds = CGRectMake1(0, 0, 80, 30);
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Configure the view for the selected state
}

@end
