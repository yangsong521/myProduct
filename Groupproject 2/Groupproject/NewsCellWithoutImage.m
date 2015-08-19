//
//  NewsCellWithoutImage.m
//  Groupproject
//
//  Created by lanou3g on 15/6/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewsCellWithoutImage.h"
#import "NewsModel.h"

@interface NewsCellWithoutImage ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation NewsCellWithoutImage

+(NewsCellWithoutImage *)newsCellWithoutImage:(UITableView *)tableView{
    static NSString *cell_id = @"cell_Noimage";
    NewsCellWithoutImage *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NewsCellWithoutImage" owner:self options:nil]firstObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)setNewsModel:(NewsModel *)newsModel{
    self.titleLabel.text = newsModel.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
