//
//  NewsShowView.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewsShowView.h"
#import "HeadView.h"
#import "Marcro.h"
#import "HeadScrview.h"


@implementation NewsShowView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    
    HeadView *headView = [HeadView headViewWithFrame:CGRectMake(0, 20, mScreenW, 30) backgroudColor:[UIColor grayColor]];
    [self addSubview:headView];

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:button];
    
    CGFloat tableViewH = mScreenH - CGRectGetMaxY(headView.frame) ;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), mScreenW, tableViewH) style:UITableViewStyleGrouped];
    [self addSubview:self.tableView];
    
    self.tableViewHead = [HeadScrview headScrview];
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, mScreenW/2-50, mScreenW, 30)];
//    label.backgroundColor = [UIColor redColor];
//    [self.tableViewHead addSubview:label];
    
    CGFloat cha = (((mScreenW+100)*648/768.0) - 0.5*mScreenW)/2.0;
    [self.tableViewHead setContentSizeWithCGSize:CGSizeMake(mScreenW+100, (mScreenW+100)*648/768.0)];
    self.tableViewHead.contentOffset = CGPointMake(50, cha);
    self.tableViewHead.scrollEnabled = NO;
    self.tableViewHead.bounces = NO;
    self.tableView.tableHeaderView = self.tableViewHead;
    self.tableView.estimatedSectionFooterHeight = 0;
 
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mScreenW+100, (mScreenW+100)*648/768.0)];
    [self.tableViewHead addSubview:self.headImageView];
    
    /*
    HeadView *headView = [HeadView headViewWithFrame:CGRectMake(0, 20, mScreenW, 30) backgroudColor:[UIColor redColor]];
    [self addSubview:headView];
    
    CGFloat tableViewH = mScreenH - CGRectGetMaxY(headView.frame) - mTabbarH;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), mScreenW, tableViewH) style:UITableViewStyleGrouped];
    [self addSubview:self.tableView];
    
    self.tableViewHead = [HeadScrview headScrview];
    
    CGFloat cha = (mScreenW*648/768.0 - 0.5*mScreenW)/2.0;
    [self.tableViewHead setContentSizeWithCGSize:CGSizeMake(mScreenW, mScreenW*648/768.0)];
    self.tableViewHead.contentOffset = CGPointMake(0, cha);
    //    self.tableViewHead.scrollEnabled = NO;
    self.tableViewHead.bounces = NO;
    self.tableView.tableHeaderView = self.tableViewHead;
    
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mScreenW, mScreenW*648/768.0)];
    [self.tableViewHead addSubview:self.headImageView];
     */

}

-(void)buttonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonDidClick)]) {
        [self.delegate buttonDidClick];
    }
}

@end
