//
//  ScrollView.m
//  恒融汇通
//
//  Created by 陈华军 on 15/7/1.
//  Copyright (c) 2015年 陈华军. All rights reserved.
//

#import "ScrollView.h"
#define GetHeight [UIScreen mainScreen].bounds.size.height //获取屏幕高度
#define GetWidth [UIScreen mainScreen].bounds.size.width  //获取屏幕宽度

@interface ScrollView()<UIScrollViewDelegate>
//创建滚动视图的对象和点对象
@property(strong, nonatomic) UIScrollView *  scrollV;
@property(strong, nonatomic) UIPageControl * pageC;
@end
@implementation ScrollView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.scrollV = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.scrollV.pagingEnabled = YES;
        self.scrollV.delegate = self;
        [self addSubview:self.scrollV];
    }
    return self;
}
//重写方法
-(instancetype)initWithFrame:(CGRect)frame andArrImageName:(NSArray *)arrImageName
{
    if (self = [super initWithFrame:frame])
    {
        //初始化滚动视图的对象并设置位置大小
        self.scrollV = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.scrollV.pagingEnabled = YES;//设置是否打开用户交互
//        self.scrollV.bounces = NO;
        self.scrollV.delegate = self;
        [self addSubview:self.scrollV];//添加到视图上
        //赋值
        self.arrImageName = arrImageName;
        //初始化点对象并设置大小
        self.pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.scrollV.frame.size.height-20, GetWidth, 20)];
        self.pageC.userInteractionEnabled = NO;//设置关闭用户交互
        self.pageC.numberOfPages = arrImageName.count;//设置总的点数
        self.pageC.currentPage = 0;//设置第一点的位置
        self.pageC.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:self.pageC];
    }
    return self;
}
//arrImageName的set方法
-(void)setArrImageName:(NSArray *)arrImageName
{
    //赋值 避免死循环self.arrImageName
    _arrImageName = arrImageName;
    //通过循环
    for (int i = 0; i < arrImageName.count; i++)
    {
        //添加图片
        UIImageView * imge = [[UIImageView alloc]initWithFrame:CGRectMake(GetWidth*i, 0, GetWidth, self.scrollV.frame.size.height)];
        
        imge.image = [UIImage imageWithData:arrImageName[i]];
        //显示到滚动视图上
        [self.scrollV addSubview:imge];
        
    }
    //设置滚动视图的范围
    self.scrollV.contentSize = CGSizeMake(GetWidth*(arrImageName.count), 0);
    //隐藏水平线
    self.scrollV.showsHorizontalScrollIndicator = NO;
    //创建计时器
//    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollviewAction) userInfo:nil repeats:YES];
//    [timer fire];//马上执行一次
}
//实现方法
-(void)scrollviewAction
{
    //设置一开始滚动的位置 为第二张
    [self.scrollV setContentOffset:CGPointMake(self.scrollV.contentOffset.x + GetWidth, 0) animated:YES];
    //拿到当前滚动到第几张
    int i = self.scrollV.contentOffset.x/GetWidth;
    //总共多少点
    int j = (int)self.arrImageName.count;
    //设置点的位置跟着滚动视图的位置在变
    self.pageC.currentPage = i>j-1?0:i;
    if (i == j+1)
    {
        [self.scrollV setContentOffset:CGPointMake(self.scrollV.frame.size.width, 0) animated:NO];
        [self scrollviewAction];
    }
  
}
#pragma mark - Scroller代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ((int)scrollView.contentOffset.x % (int)GetWidth == 0) {
        self.pageC.currentPage = (int)scrollView.contentOffset.x / GetWidth;
    }
}

@end
