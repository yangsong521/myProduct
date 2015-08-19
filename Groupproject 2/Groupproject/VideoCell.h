//
//  VideoCell.h
//  Groupproject
//
//  Created by lanou3g on 15/6/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;

@interface VideoCell : UITableViewCell

@property(nonatomic,strong) VideoModel *videoModel;

+(VideoCell *)videoCellWithTableView:(UITableView *)tableView;
+(CGFloat)Height;
@end
