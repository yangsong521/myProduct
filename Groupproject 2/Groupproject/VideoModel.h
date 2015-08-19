//
//  VideoModel.h
//  Groupproject
//
//  Created by lanou3g on 15/6/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property(nonatomic,copy) NSString *category;
@property(nonatomic,copy) NSString *coverForDetail;
@property(nonatomic,copy) NSString *coverBlurred;
@property(nonatomic,copy) NSString *Description;
@property(nonatomic,assign) int duration;
@property(nonatomic,copy) NSString *playUrl;
@property(nonatomic,copy) NSString *title;

@end
