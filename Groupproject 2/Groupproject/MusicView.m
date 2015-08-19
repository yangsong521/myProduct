//
//  MusicView.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicView.h"
#import "Marcro.h"

@implementation MusicView


-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, mScreenW, 35)];
    headView.backgroundColor = [UIColor grayColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(mScreenW-70, 2, 70, 30);
    _button.titleLabel.font = [UIFont systemFontOfSize:15];
    [_button setTitle:@"往期分类" forState:UIControlStateNormal];
    [_button addTarget:self.delegate action:@selector(categoryButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_button];
    
    self.abutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _abutton.frame = CGRectMake(0, 2, 70, 30);
    _abutton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_abutton setTitle:@"每日精选" forState:UIControlStateNormal];
    [_abutton addTarget:self.delegate action:@selector(todayButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_abutton];
    
    [self addSubview:headView];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 55, mScreenW, mScreenH - 69-35) style:UITableViewStyleGrouped];
    [self addSubview:self.tableView];
}

@end
