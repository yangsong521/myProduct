//
//  NewsCellWithoutImage.h
//  Groupproject
//
//  Created by lanou3g on 15/6/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

@interface NewsCellWithoutImage : UITableViewCell
@property(nonatomic,strong) NewsModel *newsModel;

+(NewsCellWithoutImage *)newsCellWithoutImage:(UITableView *)tableView;
@end
