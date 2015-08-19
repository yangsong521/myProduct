//
//  EndView.m
//  Groupproject
//
//  Created by lanou3g on 15/7/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "EndView.h"
#import "Marcro.h"

@implementation EndView


+(UIView *)endView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenW, mScreenW*0.6)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mScreenW, 45)];
    label.text = @"-END-";
    label.textAlignment = NSTextAlignmentCenter;
    label.center = view.center;
    [view addSubview:label];
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
