//
//  ChatCell.h
//  Groupproject
//
//  Created by lanou3g on 15/6/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatModelFrame;

@interface ChatCell : UITableViewCell
@property(nonatomic,strong) ChatModelFrame *chatModelF;
+(ChatCell *)chatCellWithTableView:(UITableView *)tableView;
@end
