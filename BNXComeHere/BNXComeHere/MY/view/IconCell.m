//
//  IconCell.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/24.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
#import "IconCell.h"

@interface IconCell ()

@end

@implementation IconCell

+ (IconCell *)iconCell{
    return [[IconCell alloc]initIconCell];
}

- (IconCell *)initIconCell{
    UINib *nib = [UINib nibWithNibName:@"IconCell" bundle:nil];
    IconCell *cell = [[nib instantiateWithOwner:nil options:nil] firstObject];
    cell.iconLabel.text = @"修改头像";
    
    if ([UserInfo shareUserInfo].iconFilePath) {
        cell.iconImageView.image = [UIImage imageWithContentsOfFile:[UserInfo shareUserInfo].iconFilePath];
    }else{
        
        
        
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:userIconUrl] placeholderImage:[UIImage imageNamed:@"修改头像图标@3x.png"]];
    }
    
    

    
    cell.iconImageView.layer.cornerRadius = (cell.iconImageView.size.width/2);
    cell.iconImageView.clipsToBounds = YES;
    if (cell.iconImageView.image == nil) {
        cell.iconImageView.image = [UIImage imageNamed:@"修改头像图标@3x.png"];
    }
    
    return cell;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
