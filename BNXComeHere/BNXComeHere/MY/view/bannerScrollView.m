//
//  bannerScrollView.m
//  BNXComeHere
//
//  Created by  徐智 on 15/12/14.
//  Copyright © 2015年 linyj. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "bannerScrollView.h"

@interface bannerScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIPageControl *pageC;
@property (nonatomic,retain)NSTimer *timer;
@property (nonatomic,retain)UIScrollView *scrollView;

@end

@implementation bannerScrollView

- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    self.pageC.numberOfPages = dataArray.count;
    if (dataArray.count < 2) {
        if (dataArray.count == 0) {
            UIImageView *imageView = (UIImageView *)[self viewWithTag:1125];
            imageView.image = [UIImage imageNamed:@"ugc-photo"];
            self.scrollView.scrollEnabled = NO;
        }else{
            [self updateCurViewWithPage:0];
        }
        
    }else{
        [self updateCurViewWithPage:0];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    
}

- (void)timerAction{
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

//获取索引
- (NSInteger)updateCurrentpage:(NSInteger)page{
    NSInteger count = self.dataArray.count;
    if (count > 0) {
        return (count + page)%count;
    }else{
        return 0;
    }
    
    
}

//替换数据源
- (void)updateCurViewWithPage:(NSInteger)page{
    NSInteger pre = [self updateCurrentpage:page-1];
    self.currentpage = [self updateCurrentpage:page];
    NSInteger last = [self updateCurrentpage:page+1];
    [self.currentArray removeAllObjects];
    
    [self.currentArray addObject:self.dataArray[pre]];
    [self.currentArray addObject:self.dataArray[self.currentpage]];
    [self.currentArray addObject:self.dataArray[last]];
    for (int i = 0; i < 3 ; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:1124+i];
//        NSDictionary *dic = self.currentArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.currentArray[i]]placeholderImage:[UIImage imageNamed:@"ugc-photo"]];
    }
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    self.pageC.currentPage = self.currentpage;
}

- (void)tap:(UITapGestureRecognizer *)tap{
    self.tapBlock(self.currentpage);
    
}

//每次滑动都会调用该方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = self.scrollView.contentOffset.x;
    if (x >= self.frame.size.width * 2) {
        [self updateCurViewWithPage:self.currentpage + 1];
    }else if (x <= 0){
        [self updateCurViewWithPage:self.currentpage - 1];
    }
}

//初始化滑动视图
- (void)initWithScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    self.currentArray = [NSMutableArray arrayWithCapacity:3];
    //遍历创建三张显示的图片
    for (int i = 0; i < 3; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        
        imageV.clipsToBounds = YES;
        imageV.tag = 1124+i;

        [_scrollView addSubview:imageV];
    }
    [self addSubview:_scrollView];
}

- (instancetype)initWithFrame:(CGRect)frame array:(NSMutableArray *)array{
    if (self = [super initWithFrame:frame]) {

        [self initWithScrollView];
        self.pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30)];
        self.pageC.currentPageIndicatorTintColor = [UIColor redColor];
        self.pageC.pageIndicatorTintColor = [UIColor grayColor];
//        self.pageC.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.pageC];
        
        self.dataArray = array;
        
    }
    return self;
}

+ (instancetype)bannerScrollVWithFrame:(CGRect)frame array:(NSMutableArray *)array{
    return [[bannerScrollView alloc]initWithFrame:frame array:array];
}
@end
