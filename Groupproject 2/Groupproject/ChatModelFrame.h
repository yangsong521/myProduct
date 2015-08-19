//
//  ChatModelFrame.h
//  Groupproject
//
//  Created by lanou3g on 15/6/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ChatModel;

@interface ChatModelFrame : NSObject
@property(nonatomic,strong) ChatModel *chatModel;
@property(nonatomic,assign) CGRect timeF;
@property(nonatomic,assign) CGRect textF;
@property(nonatomic,assign) CGRect iconF;
@property(nonatomic,assign) CGFloat cellHeight;

-(void)caculateFrameWithChatModel:(ChatModel *)chatModel WithTimeLabelHeight:(CGFloat)height;
@end
