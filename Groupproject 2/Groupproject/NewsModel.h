//
//  NewsModel.h
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property(nonatomic,copy) NSString *articleID;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) NSArray *images;
@end
