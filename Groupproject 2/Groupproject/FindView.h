//
//  FindView.h
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherView;

@protocol FindViewDelegate <NSObject>

-(void)buttonDidClicked:(NSString *)string;

@end

@interface FindView : UIView
@property(nonatomic,strong) UILabel *moodLabel;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) WeatherView *weatherView;
@property(nonatomic,assign) id<FindViewDelegate> delegate;
@end
