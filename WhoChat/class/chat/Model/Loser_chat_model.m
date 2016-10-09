//
//  Loser_chat_model.m
//  WhoChat
//
//  Created by Loser on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

#define space              20

#import "Loser_chat_model.h"

@implementation Loser_chat_model

- (instancetype)initModelToMessage:(NSString *)message meHeadImgName:(NSString *)meImgName otherHeadImgName:(NSString *)otherImgName chatType:(ChatMessageType)chatType 
{
    self = [super init];
    if (self) {
        self.message = message;
        self.message = message;
        self.otherHeadImg = otherImgName;
        self.meHeadImg = meImgName;
        self.chatType = chatType;
        self.sendTime = [helper getTime];
        CGSize messageSize = [helper calculatedAccordingToTheSizeOfTheString:message withHeight:MAXFLOAT withWidth:(YScreenWidth- (40 + 10)*2)/2 andStringFont:15];
        CGFloat messageHeight = messageSize.height > 40 ? messageSize.height : 40;
        if (chatType == ChatMessageTypeOther) {
            
            self.headImgRect = YFrame(10, 20, 30, 30);
            self.messageRect = YFrame(self.headImgRect.size.width + 20, _headImgRect.origin.y+5,YScreenWidth/2 - _headImgRect.size.width - 10+space, messageHeight+space);
        }
        else
        {
            self.headImgRect = YFrame(YScreenWidth-40, 20, 30, 30);
            self.messageRect = YFrame(YScreenWidth/2 - 10-space, _headImgRect.origin.y+5,YScreenWidth/2 - _headImgRect.size.width - 10 +space, messageHeight+space);
        }
        
        // 在现实单行的时候 防止字和背景的边距太大
        if (messageHeight == 40) {
            CGSize messagesize1 = [helper calculatedAccordingToTheSizeOfTheString:message withHeight:messageHeight/2 withWidth:MAXFLOAT andStringFont:15];
            CGFloat messahe_x = chatType == ChatMessageTypeOther ? self.headImgRect.size.width + 10 : YScreenWidth-60-(messagesize1.width+10+space) ;
            self.messageRect = YFrame(messahe_x, _headImgRect.origin.y+5,messagesize1.width+10+space, messageHeight+10);
        }
        
        CGFloat cellHeight = messageHeight == 40 ? 10 : space;
        
        self.chatCellHeight = 30+messageHeight+cellHeight;
        
    }
    return self;
}

@end
