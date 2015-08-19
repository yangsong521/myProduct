//
//  FindCell.h
//  Groupproject
//
//  Created by lanou3g on 15/6/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FindModel;

@interface FindCell : UITableViewCell
@property(nonatomic,strong) FindModel *findModel;
+(FindCell *)findCell:(UITableView *)tableView;
+(CGFloat)Height;
@end
