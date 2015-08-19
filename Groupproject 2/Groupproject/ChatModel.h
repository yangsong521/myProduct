//
//  ChatModel.h
//  Groupproject
//
//  Created by lanou3g on 15/6/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    YGSMessageModelTypeMe = 0,
    YGSMessageModelTypeOther
}YGSMessageModelType;

@interface ChatModel : NSObject
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,assign) YGSMessageModelType type;


@end
