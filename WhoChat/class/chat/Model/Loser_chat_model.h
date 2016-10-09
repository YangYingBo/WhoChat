//
//  Loser_chat_model.h
//  WhoChat
//
//  Created by Loser on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Loser_chat_model : NSObject
@property (nonatomic,strong) NSString *message; // 聊骚内容
@property (nonatomic,strong) NSString *sendTime; // 显示时间
@property (nonatomic,assign) CGRect messageRect;// 内容rect
@property (nonatomic,assign) CGFloat chatCellHeight;// cell高度
@property (nonatomic,assign) ChatMessageType chatType;// 标记聊骚对方
@property (nonatomic,assign) BOOL isShowTime;// 是否显示时间
@property (nonatomic,strong) NSString *otherHeadImg;// 聊骚对方的头像
@property (nonatomic,strong) NSString *meHeadImg;// 自己的头像
@property (nonatomic,assign) CGRect headImgRect;
- (instancetype)initModelToMessage:(NSString *)message meHeadImgName:(NSString *)meImgName otherHeadImgName:(NSString *)otherImgName chatType:(ChatMessageType)chatType;
@end
