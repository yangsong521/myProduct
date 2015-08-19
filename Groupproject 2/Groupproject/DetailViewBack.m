//
//  DetailView.m
//  Groupproject
//
//  Created by lanou3g on 15/6/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DetailViewBack.h"
#import "Marcro.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"
#import "LazyFadeInView.h"


@interface DetailViewBack ()
@property (strong, nonatomic) LazyFadeInView *fadeInView;
@end
@implementation DetailViewBack
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
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, mScreenW, mScreenW)];
    scroll.contentSize = CGSizeMake(imageW, mScreenW);
    scroll.contentOffset = CGPointMake(imageX, 0);
    scroll.scrollEnabled = NO;
    [self addSubview:scroll];
    
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(-0, 0, imageW, mScreenW)];
    self.imageView.backgroundColor = [UIColor blueColor];
    [scroll addSubview:self.imageView];
    
    CGFloat belowImageY = CGRectGetMaxY(self.imageView.frame);
    CGFloat belowImageH = mScreenH - belowImageY;
    self.belowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, belowImageY, mScreenW, belowImageH)];
    self.belowImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.belowImageView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenW, belowImageH)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    [self.belowImageView addSubview:view];
    
    
    CGFloat color = 224/255.0;
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, mScreenW - 20, 20)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.belowImageView addSubview: self.titleLabel];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame), mScreenW -20, 20)];
    label.text = @"-------------------";
    label.textColor = [UIColor colorWithRed:color green:color blue:color alpha:1];
    [self.belowImageView addSubview:label];
    
    
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame), mScreenW -20, 20)];
    self.timeLabel.textColor = [UIColor colorWithRed:color green:color blue:color alpha:1];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [self.belowImageView addSubview:self.timeLabel];
    
    self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.timeLabel.frame), mScreenW -20, 100)];
    self.descLabel.textColor = [UIColor colorWithRed:color green:color blue:color alpha:1];
    self.descLabel.font = [UIFont systemFontOfSize:13];
    self.descLabel.numberOfLines = 0;
    [self.belowImageView addSubview:self.descLabel];
    //    self.descLabel.backgroundColor = [UIColor purpleColor];
    
}


-(void)setModel:(VideoModel *)model{
    
//    LazyFadeInView *fade = [[LazyFadeInView alloc] initWithFrame:CGRectMake(20, 120, 280, 200)];
//    fade.text = @"Stray birds of summer come to my window to sing and fly away.";
//    fade.textColor = [UIColor whiteColor];
//    fade.textFont = [UIFont systemFontOfSize:40];
//    self.fadeInView = fade;
//    [self addSubview:self.fadeInView];
    
    
    
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil options:SDWebImageRetryFailed];
    
    [self.belowImageView sd_setImageWithURL:[NSURL URLWithString:model.coverBlurred] placeholderImage:nil options:SDWebImageRetryFailed];
    
    self.titleLabel.text = model.title;
    
    int fen = model.duration/60;
    int miao = model.duration%60;
    NSString *string = [NSString stringWithFormat:@"#%@  /  %02d' %02d\"",model.category,fen,miao];
    self.timeLabel.text = string;
    
    self.descLabel.text = model.Description;
    self.descLabel.frame = CGRectMake(self.descLabel.frame.origin.x, self.descLabel.frame.origin.y+5, mScreenW-20, [self HeightForString: model.Description]);
    
}

-(CGFloat)HeightForString:(NSString *)string{
    CGSize size = CGSizeMake(mScreenW-20, MAXFLOAT);
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
    
    CGRect temp = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return temp.size.height;
}

@end
