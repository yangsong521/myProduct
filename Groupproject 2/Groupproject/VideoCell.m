//
//  VideoCell.m
//  Groupproject
//
//  Created by lanou3g on 15/6/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "VideoCell.h"
#import "Marcro.h"
#import "UIImageView+WebCache.h"
#import "VideoModel.h"

@interface VideoCell ()
@property (strong, nonatomic) UIImageView *mainImageView;
@property (strong, nonatomic) UIButton *coverButton;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *descLabel;

@end

@implementation VideoCell

-(UIImageView *)mainImageView{
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mScreenW, mScreenW*0.6)];
    }
    return _mainImageView;
}
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        CGFloat titleH = 35;
        CGFloat titleY = mScreenW*0.6/2 - titleH+10;
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleY, mScreenW, titleH)];
    }
    return _titleLabel;
}

-(UILabel *)descLabel{
    if (_descLabel == nil) {
        CGFloat descH = 35;
        CGFloat descY = mScreenW*0.6/2;
        self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, descY, mScreenW, descH)];
    }
    return _descLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutUI];
    }
    return  self;
}

-(void)layoutUI{
    self.mainImageView.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:self.mainImageView];
    
    self.coverButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, mScreenW, mScreenW*0.6)];
    self.coverButton.backgroundColor = [UIColor blackColor];
    self.coverButton.alpha = 0.3;
    [self.mainImageView addSubview:self.coverButton];

    self.titleLabel.text = @"adfjakldsjf";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.mainImageView addSubview:self.titleLabel];
    
    self.descLabel.text = @"赫赫";
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.font = [UIFont fontWithName:nil size:13];
    self.descLabel.textColor = [UIColor whiteColor];
    [self.mainImageView addSubview:self.descLabel];
}

+(VideoCell *)videoCellWithTableView:(UITableView *)tableView{
    static NSString *cell_id = @"cell";
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[VideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)setVideoModel:(VideoModel *)videoModel{
    _videoModel = videoModel;
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:videoModel.coverForDetail] placeholderImage:nil options:SDWebImageRetryFailed];
    self.titleLabel.text = videoModel.title;
    
    int fen = videoModel.duration/60;
    int miao = videoModel.duration%60;
    NSString *string = [NSString stringWithFormat:@"#%@  /  %02d' %02d\"",videoModel.category,fen,miao];
    self.descLabel.text = string;
}
+(CGFloat)Height{
    return mScreenW * 0.6;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
