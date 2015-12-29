//
//  wineCell.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/15.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "product.h"
#import "UIImageView+WebCache.h"
#import "wineCell.h"

@interface wineCell ()
@property (nonatomic,retain)UIView *blueView;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UIView *lineView;
@property (nonatomic,retain)UIButton *moreBtn;
@property (nonatomic,retain)NSMutableArray *subTitleArray;
@property (nonatomic,retain)NSMutableArray *imageSArray;
@property (nonatomic,retain)UIImageView *leftWintImageV;
@property (nonatomic,retain)UILabel *giftLabel;
@end

@implementation wineCell


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
    static NSString *ID = @"wine";
    wineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[wineCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
    
}

- (void)setFrame:(CGRect)frame{
//    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Configure the view for the selected state
}


- (void)setWineArray:(NSMutableArray *)wineArray{
    _wineArray = wineArray;
        unsigned long count = wineArray.count;
        for (int i = 0; i < count; i++) {
            product *pro = wineArray[i];
            self.titleLabel.text = @"名酒荟";
           
            if (i < 4) {
                if (pro.pics.count > 0) {
//                    NSString *urlS = [NSString stringWithFormat:demoMiddlegUrl,pro.vendor,pro.pics[0]];
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
        [self.moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        self.moreBtn.layer.borderWidth = 1;
        self.moreBtn.layer.borderColor = [UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f].CGColor;
        self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.moreBtn];
        
        
        for (int i = 0; i < 4; i++) {
            UIImageView *imageV = [[UIImageView alloc]init];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            [imageV addGestureRecognizer:tap];
            imageV.tag = 7726+i;
            imageV.contentMode = UIViewContentModeScaleAspectFill;
            imageV.clipsToBounds = YES;
            UILabel *titleL = [[UILabel alloc]init];
            titleL.textAlignment = NSTextAlignmentCenter;
            switch (i) {
                case 0:
                    titleL.text = @"葡萄酒";
                    break;
                case 1:{
                    titleL.text = @"白酒";
                }
                    break;
                case 2:{
                    titleL.text = @"洋酒";
                }
                    break;
                case 3:{
                    titleL.text = @"黄酒";
                }
                    break;
                default:
                    break;
            }
            titleL.font = [UIFont systemFontOfSize:11];
            titleL.backgroundColor = [UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f];
            titleL.textColor = [UIColor whiteColor];
            [imageV addSubview:titleL];
            [self.subTitleArray addObject:titleL];
            [self.contentView addSubview:imageV];
            [self.imageSArray addObject:imageV];
        }
        
        self.leftWintImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"名酒荟左侧图"]];
        [self.contentView addSubview:self.leftWintImageV];
        
        self.giftLabel = [[UILabel alloc]init];
        self.giftLabel.font = [UIFont boldSystemFontOfSize:13];
        self.giftLabel.textAlignment = NSTextAlignmentCenter;
        self.giftLabel.text = @"送礼组合套装";
        [self.contentView addSubview:self.giftLabel];
        
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap{
    if (self.wineArray.count > 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(detailWineProductWithProduct:)]) {
            product *pro = self.wineArray[tap.view.tag-7726];
            [self.delegate detailWineProductWithProduct:pro];
     

        }
    }
   
}

- (void)more{
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreWineProductWithProduct:)]) {
        if (self.wineArray.count > 0) {
            [self.delegate moreWineProductWithProduct:self.wineArray[0]];
        }
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.blueView.frame = CGRectMake(15, 5, 3, 15);
    CGFloat maxX = CGRectGetMaxX(self.blueView.frame);
    self.titleLabel.frame = CGRectMake(maxX+10, 2, self.contentView.frame.size.width-(maxX+10), 25);
    self.leftWintImageV.frame = CGRectMake(CGRectGetMidX(self.blueView.frame), CGRectGetMaxY(self.blueView.frame)+10, 130, 180);
    self.giftLabel.frame = CGRectMake(self.leftWintImageV.frame.origin.x, CGRectGetMaxY(self.leftWintImageV.frame)+10, self.leftWintImageV.frame.size.width, 20);
    
    int widthborder = 10;
    int leftBorder = 10;
    int width = (self.contentView.frame.size.width-CGRectGetMaxX(self.leftWintImageV.frame)-2*leftBorder-widthborder)/2;
    CGFloat allHight = CGRectGetMaxY(self.giftLabel.frame)-self.leftWintImageV.frame.origin.y;
    int heightBorder = 5;
    int height = (allHight- heightBorder)/2;
    
    for (int i = 0;i < self.subTitleArray.count ; i++) {
        UIImageView *imageV = self.imageSArray[i];
        imageV.frame = CGRectMake(CGRectGetMaxX(self.leftWintImageV.frame)+leftBorder+i%2*(width+widthborder), self.leftWintImageV.frame.origin.y+i/2*(height+heightBorder), width, height);
        
        UILabel *subTitleL = self.subTitleArray[i];
        subTitleL.frame = CGRectMake(0, 0, 35, 15);
    }
   
    self.lineView.frame = CGRectMake(20, CGRectGetMaxY(self.giftLabel.frame)+10, self.contentView.frame.size.width-40, 1);
    self.moreBtn.center = CGPointMake(self.contentView.frame.size.width/2, CGRectGetMaxY(self.lineView.frame)+25);
    self.moreBtn.bounds = CGRectMake(0, 0, 80, 30);
    
}


- (void)awakeFromNib {
    // Initialization code
}



@end
