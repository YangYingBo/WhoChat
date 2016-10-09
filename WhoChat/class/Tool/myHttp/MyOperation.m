//
//  MyOperation.m
//  MVVM
//
//  Created by 求罩 on 16/4/9.
//  Copyright © 2016年 求罩. All rights reserved.
//

#import "MyOperation.h"

@interface MyOperation ()<NSURLConnectionDataDelegate>

@end

@implementation MyOperation

{
    NSMutableData *downLoadData;
    
    BOOL isDownLoadFinish;
    
    long long bigSize;
}



+ (MyOperation *)sharedMyOperation
{
    static dispatch_once_t onceToken;
    static MyOperation *myOPeration;
    dispatch_once(&onceToken, ^{
        myOPeration = [[MyOperation alloc] init];
    });
    
    return myOPeration;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        downLoadData = [NSMutableData data];
    }
    return self;
}

- (void)downLoadProgress:(void(^)(CGFloat progress))progress
{
    self.downLoadProgress = progress;
}
- (void)GET:(NSString *)url requestSuccess:(void (^)(MyOperation *))success requestFailure:(void (^)(NSError *))failure
{
    self.requestFailure = failure;
    self.requestSuccess = success;
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self startGETRequest:[NSURL URLWithString:url]];
    
}

- (void)POST:(NSString *)url parame:(id)parame requestSuccess:(void (^)(MyOperation *))success requestFailure:(void (^)(NSError *))failure
{
    self.requestFailure = failure;
    self.requestSuccess = success;
    
    [self startPOSTRequestURl:[NSURL URLWithString:url] withPOSTParamete:parame];
}

// 基本的格式，一般用于发送文字信息
- (void)startPOSTRequestURl:(NSURL *)url withPOSTParamete:(NSDictionary *)paramete
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    request.timeoutInterval = 5;// 请求时间
    request.HTTPMethod = @"POST";// 请求类型
    
    NSArray *keys = [paramete allKeys];
    NSMutableArray *KeyAndValueArr = [NSMutableArray array];
    
    for (NSString *key in keys) {
        
        [KeyAndValueArr addObject:[NSString stringWithFormat:@"%@=%@",key,[paramete valueForKey:key]]];
        
    }
    
    NSString *postBody = [KeyAndValueArr componentsJoinedByString:@"&"];
    
    request.HTTPBody = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)startGETRequest:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
//    NSURLComponents
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}


// 当上一个线程结束时会自动调用
- (void)main
{
    NSLog(@"%@",[NSThread currentThread]);
    
    if (!isDownLoadFinish) {
        [[NSRunLoop currentRunLoop] acceptInputForMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];
    }
    
    NSLog(@"上个任务  被移除");
}

#pragma mark ====   NSURLConnectionDataDelegate
// 得到服务器响应响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    downLoadData.length = 0;
    
    bigSize = [response expectedContentLength];
    
    
}

// 开始请求
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [downLoadData appendData:data];
    
    CGFloat downLoadProgress = (CGFloat)downLoadData.length/bigSize;
    
    NSLog(@"下载进度      %f",downLoadProgress);
//    self.downLoadProgress(downLoadProgress);
    
}
// 请求完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    isDownLoadFinish = YES;
    
    _requestData = downLoadData;
    _requestString = [[NSString alloc] initWithData:downLoadData encoding:NSUTF8StringEncoding];
    
    if (self.requestSuccess) {
        self.requestSuccess(self);
    }
}

// 请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    isDownLoadFinish = YES;
    
    if (self.requestFailure) {
        self.requestFailure(error);
    }
}


@end
