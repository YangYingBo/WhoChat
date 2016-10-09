//
//  Loser_chatInputField_view.h
//  WhoChat
//
//  Created by Loser on 16/9/6.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Loser_chatInputField_view : UIView

@property (nonatomic,strong) void (^sendChatMessageBlock)(NSString *message);


@property (nonatomic,strong) UITextField *inputField;
@property (nonatomic,strong) UIButton *changeChatTypeBtn;
@property (nonatomic,strong) UIButton *changeLookBtn;
@end
