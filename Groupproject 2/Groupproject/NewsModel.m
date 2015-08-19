//
//  NewsModel.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.articleID = value;
    }
}
@end
