//
//  Loser_chatInputField_view.m
//  WhoChat
//
//  Created by Loser on 16/9/6.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "Loser_chatInputField_view.h"

@interface Loser_chatInputField_view ()<UITextFieldDelegate>

@end

@implementation Loser_chatInputField_view

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}


- (void)creatUI
{
    self.changeChatTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.changeChatTypeBtn setBackgroundImage:YImage(@"chat_bottom_voice_press") forState:UIControlStateNormal];
    [self.changeChatTypeBtn addTarget:self action:@selector(changeChatTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.changeChatTypeBtn];
    
    
    
    self.inputField = [[UITextField alloc] init];
    self.inputField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputField.font = YdeFaultFont(15);
    self.inputField.delegate = self;
    self.inputField.backgroundColor = [UIColor whiteColor];
    self.inputField.returnKeyType = UIReturnKeySend;
    [self addSubview:self.inputField];
    
    
    
    self.changeLookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.changeLookBtn setBackgroundImage:YImage(@"chat_bottom_smile_press") forState:UIControlStateNormal];
    [self.changeLookBtn addTarget:self action:@selector(changeLookBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.changeLookBtn];
    
    
    [_changeChatTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.width.height.equalTo(@40);
    }];
    
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(_changeChatTypeBtn.mas_right).offset(10);
        make.right.equalTo(_changeLookBtn.mas_left).offset(-10);
        make.height.equalTo(@40);
    }];
    
    [self.changeLookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.width.equalTo(@40);
    }];
    
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (self.sendChatMessageBlock) {
        self.sendChatMessageBlock(textField.text);
    }
    textField.text = @"";
    return YES;
}

#pragma mark    =====================  改变聊天模式
- (void)changeChatTypeBtnClick:(UIButton *)sender
{
    
}

#pragma mark    =====================   切换到表情包
- (void)changeLookBtnClick
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
