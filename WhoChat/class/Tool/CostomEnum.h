//
//  CostomEnum.h
//  MyObjective
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 求罩. All rights reserved.
//

typedef enum {
    ABHelperCanNotAddressBook = 0,// 连接失败
    ABHelperExistUserName,  // 名字存在
    AbHelperNotExistUserName // 名字不存在
}ABHelperIsAddressBook;


typedef enum {
    NetworkReachabilityStatusUnknown          = -1,      //未知
    NetworkReachabilityStatusNotReachable     = 0,       //无网络
    NetworkReachabilityStatusReachableViaWWAN = 1,       //蜂窝数据网络
    NetworkReachabilityStatusReachableViaWiFi = 2,       //WiFi
}NetworkStatus;

typedef enum {
    
    ChatMessageTypeMe = 0,
    ChatMessageTypeOther =1,
    
}ChatMessageType;
