//
//  NavigationBar.m
//  MountSongLake
//
//  Created by zfgj on 13-12-27.
//  Copyright (c) 2013年 zfgj. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 64)];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithRed:25/255.0 green:174/255.0 blue:217/255.0 alpha:1.0f]];
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setFrame:CGRectMake(0, 20, 50, 44)];
        [_leftButton setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_leftButton];
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setFrame:CGRectMake(UI_SCREEN_WIDTH-40, 20, 40, 40)];
        [_rightButton setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_rightButton];
        

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width-200)/2, 20, 200, 44)];

        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:22.0f]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_titleLabel];
    }
    return self;
}

@end
