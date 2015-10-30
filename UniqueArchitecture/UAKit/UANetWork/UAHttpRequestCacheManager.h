//
//  UAHttpRequestCacheManager.h
//  UniqueArchitecture
//
//  Created by summer on 15/6/5.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UAHttpRequestCacheModel : UAHttpRequestModel

/**
 *  最近一次请求时间
 */
@property (nonatomic, assign) CGFloat startTime;

/**
 *  缓存时效长度
 */
@property (nonatomic, assign) CGFloat leaveTimeout;


+ (instancetype)model;
/**
 *  判断当前缓存策略request 是否再生命周期以内，
 *
 *  @return yes:当前request仍在有效期内； NO表示已过期
 */
- (BOOL)isValid;
@end

@interface UAHttpRequestCacheManager : NSObject

@property (nonatomic,retain) UAHttpRequestCacheModel  *requestModel;
@property (nonatomic,strong) NSMutableDictionary      *cacheRequestLists;
@property (retain) NSRecursiveLock                    *accessLock;


//+ (instancetype)manager;
+ (instancetype)shareInstance;

- (void)GET:(NSString *)url parameters:(UAHttpRequestCacheModel *)requestModel
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
