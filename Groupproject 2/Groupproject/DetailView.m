//
//  DetailView.m
//  Groupproject
//
//  Created by lanou3g on 15/6/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DetailView.h"
#import "Marcro.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"
#import "LazyFadeInView.h"


@interface DetailView ()
@property (strong, nonatomic) LazyFadeInView *fadeInViewTitle;
@property (strong, nonatomic) LazyFadeInView *fadeInViewOther;
@property (strong, nonatomic) LazyFadeInView *fadeInViewTime;
@property (strong, nonatomic) LazyFadeInView *fadeInViewDesc;
@end
@implementation DetailView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    CGFloat imageW = mScreenW / 0.6;
    CGFloat imageX = (imageW - mScreenW)/2.0;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, mScreenW, 30)];
    headView.backgroundColor = [UIColor grayColor];
    [self addSubview:headView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:button];
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, mScreenW, mScreenW)];
    scroll.contentSize = CGSizeMake(imageW, mScreenW);
    scroll.contentOffset = CGPointMake(imageX, 0);
    scroll.scrollEnabled = NO;
    [self addSubview:scroll];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(-0, 0, imageW, mScreenW)];
    self.imageView.backgroundColor = [UIColor blueColor];
    self.imageView.userInteractionEnabled = YES;
    [scroll addSubview:self.imageView];
    
    
    UIImageView *play = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    play.image = [UIImage imageNamed:@"play"];
    [self.imageView addSubview:play];
    play.center = self.imageView.center;
    
    
    CGFloat belowImageY = CGRectGetMaxY(self.imageView.frame);
    CGFloat belowImageH = mScreenH - belowImageY;
    self.belowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, belowImageY, mScreenW, belowImageH)];
    self.belowImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.belowImageView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenW, belowImageH)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    [self.belowImageView addSubview:view];
    
    CGFloat color = 224/255.0;

    self.fadeInViewTitle = [self setupLazyFadeInViewWithFrame:CGRectMake(10, 10, mScreenW - 20, 20) withTextColor:[UIColor whiteColor] withTextFont:[UIFont boldSystemFontOfSize:17]];
    [self.belowImageView addSubview: self.fadeInViewTitle];
    
    self.fadeInViewOther = [[LazyFadeInView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.fadeInViewTitle.frame), mScreenW -20, 20)];
    self.fadeInViewOther.text = @"-------------------";
    self.fadeInViewOther.textColor = [UIColor colorWithRed:color green:color blue:color alpha:1];
    [self.belowImageView addSubview:self.fadeInViewOther];
    
    self.fadeInViewTime = [self setupLazyFadeInViewWithFrame:CGRectMake(10, CGRectGetMaxY(self.fadeInViewOther.frame)+5, mScreenW -20, 20) withTextColor:[UIColor colorWithRed:color green:color blue:color alpha:1] withTextFont:[UIFont systemFontOfSize:13]];
    [self.belowImageView addSubview:self.fadeInViewTime];
    
    self.fadeInViewDesc = [self setupLazyFadeInViewWithFrame:CGRectMake(10, CGRectGetMaxY(self.fadeInViewTime.frame), mScreenW -20, 100) withTextColor:[UIColor colorWithRed:color green:color blue:color alpha:1] withTextFont:[UIFont systemFontOfSize:13]];
    [self.belowImageView addSubview:self.fadeInViewDesc];


}

-(void)buttonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonDidClick)]) {
        [self.delegate buttonDidClick];
    }
}

-(LazyFadeInView *)setupLazyFadeInViewWithFrame:(CGRect)frame withTextColor:(UIColor *)color withTextFont:(UIFont *)font{
    LazyFadeInView *fade = [[LazyFadeInView alloc]initWithFrame:frame];
    fade.textFont = font;
    fade.textColor = color;
    return fade;
}


-(void)setModel:(VideoModel *)model{

    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil options:SDWebImageRetryFailed];
    
    [self.belowImageView sd_setImageWithURL:[NSURL URLWithString:model.coverBlurred] placeholderImage:nil options:SDWebImageRetryFailed];
    
    self.fadeInViewTitle.text = model.title;
    
    int fen = model.duration/60;
    int miao = model.duration%60;
    NSString *string = [NSString stringWithFormat:@"#%@  /  %02d' %02d\"",model.category,fen,miao];
    self.fadeInViewTime.text = string;
    
    self.fadeInViewDesc.text = model.Description;
    self.fadeInViewDesc.frame = CGRectMake(self.fadeInViewDesc.frame.origin.x, self.fadeInViewDesc.frame.origin.y+5, mScreenW-20, [self HeightForString: model.Description]);

}

-(CGFloat)HeightForString:(NSString *)string{
    CGSize size = CGSizeMake(mScreenW-20, MAXFLOAT);
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
    
    CGRect temp = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return temp.size.height;
}

@end
