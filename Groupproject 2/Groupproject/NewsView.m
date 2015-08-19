//
//  NewsView.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewsView.h"
#import "Marcro.h"
#import "HeadView.h"

@interface NewsView ()
@property(nonatomic,strong) NSDictionary *titleDict;
@property(nonatomic,strong) NSArray *titleArray;
@end

@implementation NewsView

-(NSDictionary *)titleDict{
    if (_titleDict == nil) {
        _titleDict = [NSDictionary dictionaryWithObjectsAndKeys:@"11",@"不许无聊", @"12",@"用户推荐日报",@"3",@"电影日报",@"13",@"日常心理学",@"4",@"设计日报",@"5",@"大公司日报",@"6",@"财经日报",@"10",@"互联网安全",@"2",@"开始游戏",@"7",@"音乐日报",@"9",@"动漫日报",@"8",@"体育日报",nil];
    }
    return _titleDict;
}
-(NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSArray arrayWithObjects:@"不许无聊",@"音乐日报",@"电影日报",@"日常心理学",@"设计日报",@"大公司日报",@"财经日报",@"互联网安全",@"开始游戏",@"用户推荐日报",@"动漫日报",@"体育日报", nil];
    }
    return _titleArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    HeadView *headView = [HeadView headViewWithFrame:CGRectMake(0, 20, mScreenW, 30) backgroudColor:[UIColor redColor]];
    [self addSubview:headView];
    
    CGFloat scrH = mScreenH - 20 - mTabbarH;
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, mScreenW, scrH)];
    self.mainScrollView.backgroundColor = [UIColor blueColor];
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.mainScrollView];
    
    CGFloat headH = mScreenW*0.6;
    self.headScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mScreenW, headH)];
    self.headScrollView.backgroundColor = [UIColor grayColor];
    self.headScrollView.contentSize = CGSizeMake(3*mScreenW, headH);
    self.headScrollView.pagingEnabled = YES;
    self.headScrollView.showsHorizontalScrollIndicator = NO;
    self.headScrollView.contentOffset = CGPointMake(mScreenW, 0);
    [self.mainScrollView addSubview:self.headScrollView];
    
    
    
    for (int i = 0; i<3; i++) {
        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(i*mScreenW, 0, mScreenW, headH)];
        scroll.contentSize = CGSizeMake(mScreenW, mScreenW);
        scroll.contentOffset = CGPointMake(0, mScreenW/5.0);
        scroll.scrollEnabled = NO;
        scroll.tag = 100+i;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mScreenW, mScreenW)];
        imageView.userInteractionEnabled = YES;
        CGFloat color = (arc4random()%256)/255.0;
        imageView.backgroundColor = [UIColor colorWithRed:color green:color blue:color alpha:1];

        UIButton *coverButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, mScreenW, mScreenW)];
        coverButton.backgroundColor = [UIColor blackColor];
        coverButton.alpha = 0.3;
        [coverButton addTarget:self.headDelegate action:@selector(headButton) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:coverButton];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, headH +10 , mScreenW-20, 50)];
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:17];
        [imageView addSubview:label];
        [scroll addSubview:imageView];
        [self.headScrollView addSubview:scroll];
    }
    
    
    /*
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    //设置行之间的最小距离
//    flowLayout.minimumLineSpacing = 0;
//    //设置列之间的最小距离
//    flowLayout.minimumInteritemSpacing = 0;
//    
//    //设置item的大小
//    CGFloat itemW = mScreenW/3.0;
//    CGFloat itemH = itemW * 1.5;
//
//    flowLayout.itemSize = CGSizeMake(itemW, itemH);
//    //设置瀑布流的滚动方向
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    
//    CGFloat collectionH = self.mainScrollView.frame.size.height - self.headScrollView.frame.size.height;
//    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headScrollView.frame), mScreenW,collectionH ) collectionViewLayout:flowLayout];
//    self.collectionView.backgroundColor = [UIColor blueColor];
//    [self.mainScrollView addSubview:self.collectionView];
     */
    
    CGFloat buttonW = mScreenW / 3.0;
    for (int i = 0 ; i < self.titleDict.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i%3*buttonW , i/3*buttonW + headH , buttonW , buttonW);
        button.backgroundColor = [UIColor whiteColor];
//        [button setImage:[UIImage imageNamed:@"ButtonBg"] forState:UIControlStateNormal];
//        button.layer.borderWidth = 1;
//        button.layer.borderColor = [UIColor grayColor].CGColor;
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"news_%d.png",i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScrollView addSubview:button];
    }
    
    CGFloat pageY = headH/20.0*19;
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, pageY, mScreenW, 0)];
    self.pageControl.numberOfPages = 5;
    [self.mainScrollView addSubview:self.pageControl];
    
    self.mainScrollView.contentSize = CGSizeMake(mScreenW, headH + 4 * buttonW);
    
}

-(void)buttonAction:(UIButton *)sender{
    [self.delegate buttonDidClicked:[self.titleDict objectForKey:sender.titleLabel.text]];
}


@end
