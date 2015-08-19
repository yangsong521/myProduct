//
//  NewCell.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewCell.h"
#import "UIImageView+WebCache.h"
#import "NewsModel.h"

@interface NewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation NewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setNewsModel:(NewsModel *)newsModel{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.images[0]] placeholderImage:[UIImage imageNamed:@"Dark_Account_Avatar"] options:SDWebImageRetryFailed];
    self.titleLabel.text = newsModel.title;
}

+(NewCell *)newCellWithTableView:(UITableView *)tableView{
    static NSString *cell_id = @"cell_image";
    NewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NewCell" owner:self options:nil]firstObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
+(CGFloat)cellHeight{
    return 95;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
