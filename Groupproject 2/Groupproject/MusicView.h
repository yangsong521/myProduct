//
//  MusicView.h
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicViewDelegate <NSObject>

-(void)categoryButtonDidClicked:(UIButton *)sender;
-(void)todayButtonDidClicked:(UIButton *)sender;

@end

@interface MusicView : UIView
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,strong) UIButton *abutton;
@property(nonatomic,assign) id<MusicViewDelegate> delegate;
@end
