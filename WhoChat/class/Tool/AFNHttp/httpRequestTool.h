//
//  httpRequestTool.h
//  MVVM
//
//  Created by 求罩 on 16/4/8.
//  Copyright © 2016年 求罩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CostomEnum.h"

@interface httpRequestTool : NSObject
/**
 *  判断当前网络状态
 *
 *  @return 网络状态
 */
+ (NetworkStatus)GetAFNetworkStatus;
/**
 *  get
 *
 *  @param url     url
 *  @param parrame 参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)netRequestGetUrl:(NSString *)url parame:(id)parrame downLoadProgress:(void(^)(CGFloat progree))downLoadProgress success:(void(^)(id jsonDic))success failure:(void(^)(NSError *error))failure;
/**
 *  post
 *
 *  @param url     url
 *  @param parrame 参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)netRequestPostUrl:(NSString *)url parame:(id)parrame downLoadProgress:(void(^)(CGFloat progree))downLoadProgress success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
/**
 *  get请求  返回xml数据
 *
 *  @param url     url
 *  @param parrame 参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)netRequestGetUrlBackXML:(NSString *)url parame:(id)parrame downLoadProgress:(void(^)(CGFloat progree))downLoadProgress success:(void(^)(id jsonDic))success failure:(void(^)(NSError *error))failure;

@end
