//
//  FindModel.h
//  Groupproject
//
//  Created by lanou3g on 15/6/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindModel : NSObject
@property(nonatomic,copy) NSString *s_photo_url;
@property(nonatomic,assign) int avg_price;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *branch_name;
@property(nonatomic,assign) int review_count;
//星级图片
@property(nonatomic,copy) NSString *rating_s_img_url;
@property(nonatomic,strong) NSArray *categories;
@property(nonatomic,strong) NSArray *regions;
@property(nonatomic,assign) int deal_count;
@property(nonatomic,copy) NSString *business_id;
@end
