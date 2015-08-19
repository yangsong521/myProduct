//
//  ChatView.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ChatView.h"
#import "Marcro.h"

@interface ChatView ()
@property(nonatomic,strong) UIView *chatSendView;
@end

@implementation ChatView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    CGFloat chatSendViewH = 50;
    CGFloat chatSendViewY = mScreenH - chatSendViewH - mTabbarH;
    self.chatSendView = [[UIView alloc]initWithFrame:CGRectMake(0, chatSendViewY, mScreenW, chatSendViewH)];
    self.chatSendView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self addSubview:self.chatSendView];
    
    CGFloat buttonW = chatSendViewH;
    CGFloat textFieldH = 35;
    CGFloat padding = (chatSendViewH - textFieldH)/2.0;
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(padding, padding, mScreenW - buttonW - padding, textFieldH)];
    self.textField.backgroundColor = [UIColor whiteColor];
    [self.chatSendView addSubview:self.textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMaxX(self.textField.frame)+4, 4, buttonW-8, buttonW-8);
    [button setTitle:@"发送" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.tintColor = [UIColor colorWithRed:75/255.0 green:115/255.0 blue:255/255.0 alpha:1];
    button.titleLabel.textColor = [UIColor colorWithRed:75/255.0 green:115/255.0 blue:255/255.0 alpha:1];
//    [button setImage:[UIImage imageNamed:@"fasong"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.chatSendView addSubview:button];
    
    CGFloat tableViewH = mScreenH - mTabbarH - chatSendViewH - 20;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, mScreenW, tableViewH) style:UITableViewStylePlain];
    [self addSubview:self.tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap )];
    [self addGestureRecognizer:tap];
}

-(void)buttonDidClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendButtonDidClicked)]) {
        [self.delegate sendButtonDidClicked];
    }
}
-(void)tap{
//    [self endEditing:YES];
    [self.textField resignFirstResponder];
}

@end
