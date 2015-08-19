//
//  FindView.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FindView.h"
#import "HeadView.h"
#import "Marcro.h"
#import "WeatherView.h"

@interface FindView ()
@property(nonatomic,strong) NSArray *titleArray;
@end

@implementation FindView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

-(NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSArray arrayWithObjects:@"美食", @"酒店", @"景点", @"运动健身", @"休闲娱乐", @"丽人", @"结婚", @"教育培训", @"亲子",nil];
    }
    return _titleArray;
}

-(void)layoutUI{
    HeadView *headV = [HeadView headViewWithFrame:CGRectMake(0, 20, mScreenW, 30) backgroudColor:[UIColor redColor]];
    [self addSubview:headV];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, mScreenW, mScreenH - mTabbarH - 20)];
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(mScreenW, mScreenW*1.6);
    
    
    self.weatherView = [[[NSBundle mainBundle]loadNibNamed:@"WeatherView" owner:self options:nil]firstObject];
    [self.scrollView addSubview:_weatherView];
   
    CGFloat buttonW = mScreenW / 3.0;
    CGFloat headViewH = _weatherView.frame.size.height;
    UIColor *color = [UIColor colorWithRed:231/255.0 green:1 blue:218/255 alpha:0.2];
    for (int i = 0 ; i < 9; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i%3*buttonW , i/3*buttonW + headViewH, buttonW , buttonW);
        button.backgroundColor = [UIColor whiteColor];
        [button setBackgroundColor:color];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"find_%d",i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
    }
}

-(void)buttonAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonDidClicked:)]) {
        [self.delegate buttonDidClicked:sender.titleLabel.text];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
