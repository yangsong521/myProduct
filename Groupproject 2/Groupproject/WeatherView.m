//
//  WeatherView.m
//  Groupproject
//
//  Created by lanou3g on 15/6/26.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "WeatherView.h"
#import "Marcro.h"
#import "moodModel.h"
#import "WeatherModel.h"

@interface WeatherView ()
@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempretureLabel;
@property (strong, nonatomic) IBOutlet UILabel *windLabel;
@property (strong, nonatomic) IBOutlet UILabel *moistureLabel;
@property (strong, nonatomic) IBOutlet UILabel *moodLabel;


@end

@implementation WeatherView

- (IBAction)buttonAction:(id)sender {
    [self.delegate buttonDidClicked];
}

-(void)layoutSubviews{
    
}

-(void)awakeFromNib{
    self.frame = CGRectMake(0, 0, mScreenW, mScreenW*0.6);
}

-(void)setWeatherModel:(WeatherModel *)weatherModel{
    _weatherModel = weatherModel;
    self.weatherLabel.text = weatherModel.weather;
    self.tempretureLabel.text = weatherModel.tempreture;
    self.windLabel.text = weatherModel.wind;
    self.moistureLabel.text = weatherModel.moisture;
}

-(void)setMood:(moodModel *)mood{
    _mood = mood;
    self.moodLabel.text = mood.mood;
}
@end
