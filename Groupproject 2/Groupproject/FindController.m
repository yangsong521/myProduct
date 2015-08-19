//
//  FindController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FindController.h"
#import "FindView.h"
#import "Marcro.h"
#import "SignatrueEncryption.h"
#import <CoreLocation/CoreLocation.h>
#import "WeatherModel.h"
#import "moodModel.h"
#import "WeatherView.h"
#import "FindShowController.h"
#import "ChatController.h"
#import "AFNetworking.h"

#define mBusinesses @"http://api.dianping.com/v1/business/find_businesses?"
#define mMoodURL @"http://hello.api.235dns.com/api.php?code=json&key=80c7b41e80421cb791cbbb802e4d45ad"
//#define mWeatherURL @""

@interface FindController () <CLLocationManagerDelegate,FindViewDelegate,WeatherViewDelegate>
@property(nonatomic,strong) FindView *rootView;
@property(nonatomic,strong) CLLocationManager *locationManger;
@property(nonatomic,assign) CLLocationDegrees latitude;
@property(nonatomic,assign) CLLocationDegrees longitude;
@end

@implementation FindController

-(void)loadView{
    self.rootView = [[FindView alloc]initWithFrame:mScreen];
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rootView.delegate = self;
    self.rootView.weatherView.delegate = self;
    self.locationManger = [[CLLocationManager alloc]init];
    
    self.locationManger.delegate = self;
    self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManger.distanceFilter = 1000;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8)
    {
        [self.locationManger requestAlwaysAuthorization];
    }
    else{
        [self.locationManger startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations firstObject];
    NSLog(@"%f=------%f",location.coordinate.latitude,location.coordinate.longitude);
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:mMoodURL]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data == nil || connectionError) {
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        moodModel *mood = [[moodModel alloc]init];
        mood.mood = [dict objectForKey:@"words"];
        self.rootView.weatherView.mood = mood;
    }];
    NSString *weatherURL = [NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%f,%f&output=json&ak=fZmDW5RmHoL9FfT5ANV5Plen",self.longitude,self.latitude];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weatherURL]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        if (data == nil || connectionError) {
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        WeatherModel *weather = [[WeatherModel alloc]init];
        NSDictionary *dic = [[dict objectForKey:@"results"] firstObject];
        NSArray *array = [dic objectForKey:@"weather_data"];
        NSDictionary *dataDic = array[0];
        
        NSString *temp = [dataDic objectForKey:@"date"];
        NSRange end = [temp rangeOfString:@")"];
        NSRange begin = [temp rangeOfString:@"："];
        weather.tempreture = [[dataDic objectForKey:@"date"] substringWithRange:NSMakeRange(begin.location+1, end.location-begin.location-1)];
        weather.wind = [dataDic objectForKey:@"wind"];
        weather.moisture = [dataDic objectForKey:@"temperature"];
        weather.weather = [dataDic objectForKey:@"weather"];
        
        self.rootView.weatherView.weatherModel = weather;
    }];
    
    [self.locationManger stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusNotDetermined ) {
//        NSLog(@"还未开启授权");
    }else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
//        NSLog(@"已经授权");
        //开始定位
        [self.locationManger startUpdatingLocation];
    }else{
//        NSLog(@"授权失败或者不同意授权");
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
}

-(void)buttonDidClicked{
    ChatController *vc = [[ChatController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)buttonDidClicked:(NSString *)string{
    AFNetworkReachabilityManager *magr = [AFNetworkReachabilityManager sharedManager];
    [magr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
                [alert show];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
                [alert show];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                FindShowController *vc = [[FindShowController alloc]init];
                vc.category = string;
                vc.latitude = self.latitude;
                vc.longitude = self.longitude;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                FindShowController *vc = [[FindShowController alloc]init];
                vc.category = string;
                vc.latitude = self.latitude;
                vc.longitude = self.longitude;
                NSLog(@"%@",string);
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }];
    
    [magr startMonitoring];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
