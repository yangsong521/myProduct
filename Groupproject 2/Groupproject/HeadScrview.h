//
//  HeadScrview.h
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadScrview : UIScrollView
+(HeadScrview *)headScrview;
-(void)setContentSizeWithImageNumber:(int)number;
-(void)setContentSizeWithCGSize:(CGSize)size;
@end
