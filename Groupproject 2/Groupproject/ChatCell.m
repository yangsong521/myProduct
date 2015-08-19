//
//  ChatCell.m
//  Groupproject
//
//  Created by lanou3g on 15/6/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ChatCell.h"
#import "Marcro.h"
#import "ChatModelFrame.h"
#import "ChatModel.h"
#import "UIImage+Extension.h"

@interface ChatCell ()
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UIButton *contentButton;
@property(nonatomic,strong) UIImageView *icon;
@end

@implementation ChatCell

+(ChatCell *)chatCellWithTableView:(UITableView *)tableView{
    static NSString *cell_id = @"cell";
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[ChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.font = [UIFont fontWithName:nil size:13];
        self.timeLabel.textColor = [UIColor grayColor];
        [self addSubview:self.timeLabel];
        
        self.contentButton = [[UIButton alloc]init];
        self.contentButton.titleLabel.numberOfLines = 0 ;
        self.contentButton.titleLabel.font = [UIFont fontWithName:nil size:17.0];
        self.contentButton.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [self addSubview:self.contentButton];
        
        self.icon = [[UIImageView alloc]init];
        [self addSubview:self.icon];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return  self;
}



-(void)setChatModelF:(ChatModelFrame *)chatModelF{
    _chatModelF = chatModelF;
    //timeLabel  Frame
    ChatModel *model = chatModelF.chatModel;
    
    self.timeLabel.frame = chatModelF.timeF;
    self.timeLabel.text = model.time;
    
    if (chatModelF.chatModel.type == YGSMessageModelTypeMe) {
        self.icon.image = [UIImage imageNamed:@"touxiang"];
    }
    else{
        self.icon.image = [UIImage imageNamed:@"touxiang1"];
    }
    self.icon.frame = chatModelF.iconF;
    
    UIImage *image = nil;
    if (chatModelF.chatModel.type == YGSMessageModelTypeMe) {
        image = [UIImage resizableImageWithName:@"chat_send_nor"];
    }
    else{
        image = [UIImage resizableImageWithName:@"chat_recive_nor"];
    }
    [self.contentButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.contentButton setTitle:model.text forState:UIControlStateNormal];
    [self.contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.contentButton.frame= chatModelF.textF;
    
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
