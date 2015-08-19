//
//  WeatherView.h
//  Groupproject
//
//  Created by lanou3g on 15/6/26.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherModel;
@class moodModel;

@protocol WeatherViewDelegate <NSObject>

-(void)buttonDidClicked;

@end

@interface WeatherView : UIView
@property(nonatomic,strong) WeatherModel *weatherModel;
@property(nonatomic,strong) moodModel *mood;
@property(nonatomic,assign) id<WeatherViewDelegate> delegate;
@end
