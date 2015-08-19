//
//  ChatModelFrame.m
//  Groupproject
//
//  Created by lanou3g on 15/6/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ChatModelFrame.h"
#import "Marcro.h"
#import "ChatModel.h"

@implementation ChatModelFrame


-(void)setChatModel:(ChatModel *)chatModel{
    _chatModel = chatModel;
    CGFloat padding = 10;
    
    self.timeF = CGRectMake(0, 0, mScreenW, 30);
    
    CGFloat iconW = 30;
    CGFloat iconY = CGRectGetMaxY(self.timeF) + padding;
    if (chatModel.type == YGSMessageModelTypeMe) {
        self.iconF = CGRectMake(mScreenW - iconW - padding, iconY, iconW, iconW);
    }
    else{
        self.iconF = CGRectMake(padding, iconY, iconW, iconW);
    }
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
    CGSize size = CGSizeMake(200, MAXFLOAT);
    CGRect rect = [chatModel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    CGFloat contentY = iconY;
    CGFloat textW = rect.size.width + 2*20;
    if (chatModel.type == YGSMessageModelTypeMe) {
        self.textF = CGRectMake(self.iconF.origin.x-textW-padding, contentY, textW , rect.size.height+40);
    }
    else{
        self.textF = CGRectMake(2*padding + iconW, contentY, textW, rect.size.height+40);
    }
    
    if (CGRectGetMaxY(self.textF) > CGRectGetMaxY(self.iconF)) {
        self.cellHeight = CGRectGetMaxY(self.textF);
    }
    else{
        self.cellHeight = CGRectGetMaxY(self.iconF);
    }
}

-(void)caculateFrameWithChatModel:(ChatModel *)chatModel WithTimeLabelHeight:(CGFloat)height{
    _chatModel = chatModel;
    CGFloat padding = 10;
    
    self.timeF = CGRectMake(0, 0, mScreenW, height);
    
    CGFloat iconW = 30;
    CGFloat iconY = CGRectGetMaxY(self.timeF) ;
    if (chatModel.type == YGSMessageModelTypeMe) {
        self.iconF = CGRectMake(mScreenW - iconW - padding, iconY, iconW, iconW);
    }
    else{
        self.iconF = CGRectMake(padding, iconY, iconW, iconW);
    }
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
    CGSize size = CGSizeMake(200, MAXFLOAT);
    CGRect rect = [chatModel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    CGFloat contentY = iconY;
    CGFloat textW = rect.size.width + 2*20;
    if (chatModel.type == YGSMessageModelTypeMe) {
        self.textF = CGRectMake(self.iconF.origin.x-textW-padding, contentY, textW , rect.size.height+40);
    }
    else{
        self.textF = CGRectMake(2*padding + iconW, contentY, textW, rect.size.height+40);
    }
    
    if (CGRectGetMaxY(self.textF) > CGRectGetMaxY(self.iconF)) {
        self.cellHeight = CGRectGetMaxY(self.textF);
    }
    else{
        self.cellHeight = CGRectGetMaxY(self.iconF);
    }
}
@end
