//
//  Loser_chat_cell.m
//  WhoChat
//
//  Created by Loser on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "Loser_chat_cell.h"

@implementation Loser_chat_cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.timeLabel = [helper getLabelWithFrame:YFrame(0, 0, YScreenWidth, 20) andLabelText:@"" backgroundColor:[UIColor whiteColor] textColor:[UIColor grayColor] textFont:15 textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.timeLabel];
        
        self.headImg = [[UIImageView alloc] initWithFrame:YFrame(10, _timeLabel.bottom, 40, 40)];
        [self.contentView addSubview:self.headImg];
        
        
        self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.messageBtn .frame = CGRectMake(_headImg.right+10, _timeLabel.top, YScreenWidth/2 - _headImg.width- 20, 40);
        [self.messageBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.messageBtn.titleLabel.font = YdeFaultFont(14);
        self.messageBtn.titleLabel.numberOfLines = 0;
        [self.messageBtn  setTitle:@"你妹" forState:UIControlStateNormal];
//        self.messageBtn.layer.cornerRadius = 5;
        self.messageBtn.titleEdgeInsets = UIEdgeInsetsMake(20, 15, 20, 15);
        [self.contentView addSubview:self.messageBtn];
    }
    
    return self;
}

- (void)updataCellSubViewFrameAndText:(Loser_chat_model *)model
{
    
    self.timeLabel.text = model.sendTime;
    NSString *headImgName = model.chatType == ChatMessageTypeMe ? model.meHeadImg : model.otherHeadImg;
    self.headImg.image = YImage(headImgName);
    self.headImg.frame = model.headImgRect;
    self.messageBtn.frame = model.messageRect;
    [self.messageBtn setTitle:model.message forState:UIControlStateNormal];
    [self.messageBtn setBackgroundImage:model.chatType == ChatMessageTypeMe ? [helper resizableImage:@"chat_send_nor"] : [helper resizableImage:@"chat_recive_nor"] forState:UIControlStateNormal];
//    [self.messageBtn setBackgroundColor:model.chatType == ChatMessageTypeMe ? [UIColor blueColor]:[UIColor whiteColor]];
    [self.messageBtn setTitleColor:model.chatType == ChatMessageTypeMe ? [UIColor whiteColor]:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
