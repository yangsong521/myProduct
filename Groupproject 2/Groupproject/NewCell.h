//
//  NewCell.h
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

@interface NewCell : UITableViewCell
@property(nonatomic,strong) NewsModel *newsModel;

+(NewCell *)newCellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeight;
@end
