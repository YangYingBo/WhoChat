//
//  Loser_chat_cell.h
//  WhoChat
//
//  Created by Loser on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loser_chat_model.h"

@interface Loser_chat_cell : UITableViewCell
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIButton *messageBtn;
- (void)updataCellSubViewFrameAndText:(Loser_chat_model *)model;
@end
