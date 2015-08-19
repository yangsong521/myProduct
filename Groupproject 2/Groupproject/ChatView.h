//
//  ChatView.h
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatViewDelegate <NSObject>

-(void)sendButtonDidClicked;

@end

@interface ChatView : UIView

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) id<ChatViewDelegate> delegate;
@property(nonatomic,strong) UITextField *textField;
@end
