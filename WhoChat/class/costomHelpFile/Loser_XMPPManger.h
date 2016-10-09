//
//  Loser_XMPPManger.h
//  WhoChat
//
//  Created by Loser on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//



#import <Foundation/Foundation.h>

@protocol Loser_XMPPMangerDelegate <NSObject>

@optional

- (void)getReceiveMessage:(NSString *)msg fromeSomeonePerson:(NSString *)from;

@end

@interface Loser_XMPPManger : NSObject
/**
 *  单例
 *
 *  @return Loser_XMPPManger
 */
+ (Loser_XMPPManger *)sharedLoserXMPPManger;

@property (nonatomic,assign) id <Loser_XMPPMangerDelegate>delegate;
/**
 *  连接服务器
 *
 *  @return 是否连接
 */
- (BOOL)isConnecting;

/**
 *  发送信息
 *
 *  @param message 信息内容
 *  @param user    发给谁的
 */
- (void)sendMessage:(NSString *)message toUser:(NSString *) user;


@end
