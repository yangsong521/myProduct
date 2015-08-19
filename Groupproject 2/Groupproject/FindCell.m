//
//  FindCell.m
//  Groupproject
//
//  Created by lanou3g on 15/6/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FindCell.h"
#import "FindModel.h"
#import "UIImageView+WebCache.h"

@interface FindCell ()
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *avgLabel;

@end

@implementation FindCell


+(FindCell *)findCell:(UITableView *)tableView{
    static NSString *cell_id = @"cell";
    FindCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FindCell" owner:self options:nil]firstObject];
    }
    return cell;
}

-(void)setFindModel:(FindModel *)findModel{
    _findModel = findModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:findModel.s_photo_url] placeholderImage:nil options:SDWebImageRetryFailed];
    self.titleLabel.text = findModel.name;
    
    NSMutableString *addressString = [NSMutableString string];
    for (NSString *string in findModel.regions) {
        NSString *address = [NSString stringWithFormat:@"%@ ",string];
        [addressString appendString:address];
    }
    self.addressLabel.text = addressString;
    
    [self.ratingImageView sd_setImageWithURL:[NSURL URLWithString:findModel.rating_s_img_url] placeholderImage:nil options:SDWebImageRetryFailed];
    self.categoryLabel.text = findModel.categories[0];
    
    if (findModel.avg_price != 0) {
        NSString *avg = [NSString stringWithFormat:@"¥%d/人",findModel.avg_price];
        self.avgLabel.text = avg;
    }
    else
        self.avgLabel.text = nil;
}

+(CGFloat)Height{
    return 80;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
