//
//  CHNetWorkSingleton.h
//  adminadmin
//
//  Created by admin on 16/12/23.
//  Copyright © 2016年 adminLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"

typedef void(^FinishBlock) (id result);
typedef void(^ErrorBlock) (NSError *error);
typedef NS_ENUM(NSInteger, RequestType1) {
    RequestPostType1,
    RequestGetType1
};
@interface CHNetWorkSingleton : NSObject
@property (nonatomic, assign, getter=isConnected) BOOL connected;/**<网络是否连接*/
@property (nonatomic,assign)BOOL isNotReachable;
@property (nonatomic,assign)BOOL isHUD;

/**
 *  请求通过回调
 *
 *  @param url          上传文件的 url 地址
 *  @param httpMethod   请求类型
 *  @param finishBlock  成功
 *  @param errorBlock   失败
 *
 */
+ (AFHTTPSessionManager *)requestAFWithURL:(NSString *)url
                                    params:(NSDictionary *)params
                                httpMethod:(NSString *)httpMethod
                                     isHUD:(BOOL)ishud
                               finishBlock:(FinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock;

+ (AFHTTPSessionManager *)postMP3:(NSString *)url
                           params:(NSDictionary *)params
                         fileData:(NSData *)fileData
                      finishBlock:(FinishBlock)finishBlock
                       errorBlock:(ErrorBlock)errorBlock;

+ (AFHTTPSessionManager *)postImage:(NSString *)url
                             params:(NSDictionary *)params
                           fileData:(NSData *)fileData
                        finishBlock:(FinishBlock)finishBlock
                         errorBlock:(ErrorBlock)errorBlock;



@end

