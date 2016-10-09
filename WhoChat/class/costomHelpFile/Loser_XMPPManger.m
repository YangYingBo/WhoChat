//
//  Loser_XMPPManger.m
//  WhoChat
//
//  Created by Loser on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

/**
   1. 利用openFire搭建一个服务器
   2. 生成两个用户  用来测试是否能够通讯
   3. 一个账户在工程中登陆  另一个在电脑上自带的软件“信息”中登陆进行通讯测试
 */

#define XmppUserName                @"yang"
#define XmppPassWord                @"121912"
#define XmppServer                  @"127.0.0.1"

#import "Loser_XMPPManger.h"

@interface Loser_XMPPManger ()<XMPPStreamDelegate>
@property (nonatomic,strong) XMPPStream *stream;
@end

@implementation Loser_XMPPManger


+ (Loser_XMPPManger *)sharedLoserXMPPManger
{
    static dispatch_once_t onceToken;
    static Loser_XMPPManger *xmpp;
    dispatch_once(&onceToken, ^{
        xmpp = [[Loser_XMPPManger alloc] init];
    });
    
    return xmpp;
}

/**
 *  是否在连接服务器
 *
 *  @return 是否连接
 */
- (BOOL)isConnecting
{
    
    if (!_stream) {
        _stream = [[XMPPStream alloc] init];
        [_stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    
    /**
        - (BOOL)isDisconnected // 是否关闭了连接
        - (BOOL)isConnecting // 是否正在建立连接
        - (BOOL)isConnected // 是否已经连接成功
     
     */
    
    // 判断是否建立连接
    if (!_stream.isConnected) {
        // 设置用户
        XMPPJID *jid = [XMPPJID jidWithUser:XmppUserName domain:XmppServer resource:nil];
        _stream.myJID = jid;
        _stream.hostName = XmppServer;
        NSError *error;
        // 连接超时
        if (![self.stream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
            NSLog(@"%@",[error userInfo].description);
            return NO;
        }
    }
    
    return self.stream.isConnecting;
}

// 上线
- (void)onLine
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [self.stream sendElement:presence];
}

// 下线
- (void)upLine
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [self.stream sendElement:presence];
    [self.stream disconnect];
}

#pragma mark    =====================   XMPPStreamDelegate的方法
// connect成功之后会依次调用XMPPStreamDelegate的方法，首先调用
- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
    
}
// 然后
//在该方法下面需要使用xmppStream 的authenticateWithPassword方法进行密码验证，成功的话会响应delegate的方法 xmppStreamDidAuthenticate
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"success userName = %@, myJID = %@",sender.myJID.user, sender.myJID);
    NSError *error;
    [_stream authenticateWithPassword:XmppPassWord error:&error];
    NSLog(@"%@",[error userInfo].description);
    
}

// 密码验证成功时候调用这个代理方法
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"success userName = %@, myJID = %@",sender.myJID.user, sender.myJID);
    // 验证成功就上线
    [self onLine];
}
// 验证失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"用户名或者密码错误 error = %@",error);
}

- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    debugLog(@"没有注册");
}

// 收到消息
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    debugLog(@"msg  %@  from  %@",msg,from);
    
    if ([self.delegate respondsToSelector:@selector(getReceiveMessage:fromeSomeonePerson:)]) {
        [self.delegate getReceiveMessage:msg fromeSomeonePerson:from];
    }
}

//收到好友状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
    
    NSLog(@"presence = %@", presence);
    
    //取得好友状态
    NSString *presenceType = [presence type]; //online/offline
    //当前用户
    NSString *userId = [[sender myJID] user];
    //在线用户
    NSString *presenceFromUser = [[presence from] user];
    debugLog(@"取得好友状态  %@  当前用户  %@  在线用户 %@",presenceType,userId,presenceFromUser);
}

#pragma mark -发送消息
- (void)sendMessage:(NSString *)message toUser:(NSString *) user
{
    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:message];
    NSXMLElement *messageElement = [NSXMLElement elementWithName:@"message"];
    [messageElement addAttributeWithName:@"type" stringValue:@"chat"];
    NSString *to = [NSString stringWithFormat:@"%@@127.0.0.1",user];
    [messageElement addAttributeWithName:@"to" stringValue:to];
    [messageElement addChild:body];
    [self.stream sendElement:messageElement];
}

@end
