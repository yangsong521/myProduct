//
//  NewsView.h
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsViewDelegate <NSObject>

-(void)buttonDidClicked:(NSString *)themeName;
-(void)headButton;

@end

@interface NewsView : UIView
@property(nonatomic,strong) UIScrollView *mainScrollView;
@property(nonatomic,strong) UIScrollView *headScrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,assign) id<NewsViewDelegate> delegate;
@property(nonatomic,assign) id<NewsViewDelegate> headDelegate;

@end
