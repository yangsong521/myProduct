//
//  HeadScrview.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HeadScrview.h"
#import "Marcro.h"

@implementation HeadScrview

+(HeadScrview *)headScrview{
    CGFloat headH = mScreenW/2.0;
    HeadScrview *headScr = [[HeadScrview alloc]initWithFrame:CGRectMake(0, 0, mScreenW, headH)];
    headScr.backgroundColor = [UIColor grayColor];
    return headScr;
}

-(void)setContentSizeWithImageNumber:(int)number{
    CGFloat imageH = mScreenW / 2.0;
    self.contentSize = CGSizeMake(mScreenW * number, imageH);
}
-(void)setContentSizeWithCGSize:(CGSize)size{
    self.contentSize = size;
}

@end
