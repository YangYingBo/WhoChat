//
//  MyOperation.h
//  MVVM
//
//  Created by 求罩 on 16/4/9.
//  Copyright © 2016年 求罩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MyOperation : NSOperation


@property (nonatomic,strong) NSString *requestString;

@property (nonatomic,strong) NSMutableData *requestData;

@property (nonatomic,strong) void(^requestSuccess)(MyOperation *myOperation);

@property (nonatomic,strong) void (^downLoadProgress) (CGFloat progress);

@property (nonatomic,strong) void(^requestFailure)(NSError *error);

+ (MyOperation *)sharedMyOperation;

- (void)downLoadProgress:(void(^)(CGFloat progress))progress;

- (void)GET:(NSString *)url requestSuccess:(void(^)(MyOperation *myOperation))success requestFailure:(void(^)(NSError *error))failure;

- (void)POST:(NSString *)url parame:(id)parame requestSuccess:(void(^)(MyOperation *myOperation))success requestFailure:(void(^)(NSError *error))failure;

@end
