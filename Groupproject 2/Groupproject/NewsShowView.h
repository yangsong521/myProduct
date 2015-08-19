//
//  NewsShowView.h
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeadScrview;

@protocol NewsShowViewDelegate <NSObject>

-(void)buttonDidClick;

@end

@interface NewsShowView : UIView
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) HeadScrview *tableViewHead;
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,assign) id<NewsShowViewDelegate> delegate;
@end
