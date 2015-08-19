//
//  VideoModel.m
//  Groupproject
//
//  Created by lanou3g on 15/6/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.Description = value ;
    }
}
@end
