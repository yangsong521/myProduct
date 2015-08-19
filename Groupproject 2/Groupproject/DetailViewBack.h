//
//  DetailView.h
//  Groupproject
//
//  Created by lanou3g on 15/6/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;

@interface DetailViewBack : UIView
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIImageView *belowImageView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel *descLabel;

@property(nonatomic,strong) VideoModel *model;
@end
