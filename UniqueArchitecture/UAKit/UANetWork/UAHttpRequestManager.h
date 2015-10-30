//
//  UAHttpRequestQueue.h
//  UniqueArchitecture
//
//  Created by summer on 15/6/5.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UAHttpRequestManager : NSObject

/**
 *  是否 HTTPS connection with SSL 
 *
 *  默认是yes
 */
@property (nonatomic ,assign) BOOL allowInvalidCertificates;

+ (instancetype)manager;

/**
 *  get请求
 *  
 *  api 偏向于集约型，传入request Model，由model拼接起一个网络请求
 *  @param request request model 传入一个UARequestModel 对象
 *  @param success success 时间回调block
 *  @param failure failure 时间回调block
 *
 *  @return 
 */
- (void)GET:(NSString *)url parameters:(UAHttpRequestModel *)request
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  post请求
 *
 *  @param request 传入一个UARequestModel 对象
 *  @param success success时间回调block
 *  @param failure failure时间回调block
 *
 *  @return
 */
- (void)POST:(NSString *)url parameters:(UAHttpRequestModel *)request
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  重连型post请求
 *
 *  @param request 传入一个UARequestModel 对象
 *  @param block   第一次发起request结束时间，拼上第一次的请求结果为参数，继而发起第二次请求
 *  @param success success时间回调block
 *  @param failure failure时间回调block
 *
 *  @return
 */
- (void)POST:(NSString *)url parameters:(UAHttpRequestModel *)request
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
