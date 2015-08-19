//
//  FindShowController.h
//  Groupproject
//
//  Created by lanou3g on 15/6/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FindShowController : UIViewController
@property(nonatomic,copy) NSString *category;
@property(nonatomic,assign) CLLocationDegrees latitude;
@property(nonatomic,assign) CLLocationDegrees longitude;
@end
