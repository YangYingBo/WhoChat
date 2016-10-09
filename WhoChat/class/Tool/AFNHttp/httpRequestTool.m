//
//  httpRequestTool.m
//  MVVM
//
//  Created by 求罩 on 16/4/8.
//  Copyright © 2016年 求罩. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "httpRequestTool.h"
#import "AFNetworking.h"


@implementation httpRequestTool

+ (void)netRequestGetUrl:(NSString *)url parame:(id)parrame downLoadProgress:(void(^)(CGFloat progree))downLoadProgress success:(void(^)(id jsonDic))success failure:(void(^)(NSError *error))failure;
{
//    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manger = [[AFHTTPSessionManager alloc] init];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    [manger GET:url parameters:parrame success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
    
    [manger GET:url parameters:parrame progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        
        __block CGFloat download = downloadProgress.completedUnitCount/downloadProgress.totalUnitCount;
        if (downLoadProgress) {
            downLoadProgress(download);
        }
        
        NSLog(@"%lld",downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)netRequestPostUrl:(NSString *)url parame:(id)parrame downLoadProgress:(void(^)(CGFloat progree))downLoadProgress success:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{
    
    
    AFHTTPSessionManager *manger = [[AFHTTPSessionManager alloc] init];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manger POST:url parameters:parrame success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
    
    [manger POST:url parameters:parrame progress:^(NSProgress * _Nonnull uploadProgress) {
        // 下载进度
        __block CGFloat download = uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
        if (downLoadProgress) {
            downLoadProgress(download);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)netRequestGetUrlBackXML:(NSString *)url parame:(id)parrame downLoadProgress:(void(^)(CGFloat progree))downLoadProgress success:(void(^)(id jsonDic))success failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manger = [[AFHTTPSessionManager alloc] init];
    manger.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    [manger GET:url parameters:parrame success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
    
    [manger GET:url parameters:parrame progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        __block CGFloat download = downloadProgress.completedUnitCount/downloadProgress.totalUnitCount;
        if (downLoadProgress) {
            downLoadProgress(download);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (NetworkStatus)GetAFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
   __block NetworkStatus netWorkStatus;
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                netWorkStatus = NetworkReachabilityStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netWorkStatus = NetworkReachabilityStatusNotReachable;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netWorkStatus = NetworkReachabilityStatusReachableViaWWAN;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                netWorkStatus = NetworkReachabilityStatusReachableViaWiFi;
                break;
                
            default:
                break;
        }
        
    }] ;
    
    return netWorkStatus;
}

@end
