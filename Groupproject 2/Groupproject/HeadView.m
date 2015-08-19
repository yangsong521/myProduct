//
//  HeadView.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

+(HeadView *)headViewWithFrame:(CGRect)frame backgroudColor:(UIColor *)color{
    HeadView *headView = [[HeadView alloc]initWithFrame:frame];
    
    
    
    headView.backgroundColor = color;
    return headView;
}

@end
