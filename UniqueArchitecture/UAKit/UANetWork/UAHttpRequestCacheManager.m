//
//  UAHttpRequestCacheManager.m
//  UniqueArchitecture
//
//  Created by summer on 15/6/5.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UAHttpRequestCacheManager.h"
#import "PathHelper.h"
#import "UAUtil.h"

#define UA_CACHE_FILE_KEY @"cache_file_key"

@implementation UAHttpRequestCacheModel

+ (instancetype)model{
    return [[self alloc] init];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BOOL)isValid{
    CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
    DBGLog(@"%f",currentTime - _startTime);
    return ((currentTime - _startTime) < _leaveTimeout) ? YES : NO;
}

@end


@interface UAHttpRequestCacheManager (){
    AFHTTPRequestOperationManager *_manager;
}

@end

@implementation UAHttpRequestCacheManager

SYNTHESIZE_SINGLE_CLASS(UAHttpRequestCacheManager);


- (instancetype)init{
    self = [super init];
    if (self) {
        //
        [self initData];
        
    }
    return self;
}


- (void)initData{
    NSLog(@"%@",[PathHelper pathForLibraryCacheAFNetWorkDocment]);
    _cacheRequestLists = [[NSMutableDictionary alloc] init];
    
    _accessLock = [[NSRecursiveLock alloc] init];
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.securityPolicy.allowInvalidCertificates = YES;
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];//设置相应内容类型
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.securityPolicy.allowInvalidCertificates = YES;
}

- (void)GET:(NSString *)url parameters:(UAHttpRequestCacheModel *)requestModel
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
{
    CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",[UAHttpRequestModelManager getServerURL:requestModel],url];
    
    if ([_cacheRequestLists objectForKey:cacheKey])
    {
        UAHttpRequestCacheModel *cacheModel = [_cacheRequestLists objectForKey:cacheKey];
        //如果缓存有效，取缓存
        if ([cacheModel isValid])
        {
            //取缓存
            NSData *cacheData = [self getCacheDataWithCacheKey:cacheKey];
            success(nil,cacheData);
        }else
        {
            //缓存过期，更新当前缓存栈lsit, 实际发起网络请求
            requestModel.startTime = currentTime;
            [_cacheRequestLists removeObjectForKey:cacheKey];
            [_cacheRequestLists setObject:requestModel forKey:cacheKey];
            [self removeCachedResponseDataWithKey:cacheKey];
            //发起请求
            [self request:url parameters:requestModel success:success failure:failure];
        }
    }
    else
    {
        //缓存未命中，更新当前缓存栈lsit, 实际发起网络请求
        requestModel.startTime = currentTime;
        [_cacheRequestLists setObject:requestModel forKey:cacheKey];
        [self request:url parameters:requestModel success:success failure:failure];
    }
}

- (void)request:(NSString *)url parameters:(UAHttpRequestCacheModel *)requestModel
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    __weak __typeof(self) weakself = self;
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[UAHttpRequestModelManager getServerURL:requestModel],url];
    NSDictionary *parameters = [UAHttpRequestModelManager reBuildRequestParamtersWithModel:requestModel];
    
    [_manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        DBGLog(@"request url : %@",[operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        //写入缓存文件
        NSString *cacheKey = [weakself getCacheKey:operation.request.URL.absoluteString];
        [weakself storeCachedResponseData:responseObject Key:cacheKey];
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        //真实发起网络request ： 1.第一次请求 2. 缓存过期，从新发起网络请求，失败时间，清除list中的key-value
        NSString *cacheKey = [weakself getCacheKey:operation.request.URL.absoluteString];
        [_cacheRequestLists removeObjectForKey:cacheKey];
        
        failure(operation,error);
    }];
}

- (NSString *)getCacheKey:(NSString *)url{
    NSString *urlString = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [urlString componentsSeparatedByString:@"?"];
    NSString *cacheKey = nil;

    if ([array count] > 0) {
        cacheKey = [array objectAtIndex:0];
    }
    return cacheKey;
}

- (void)storeCachedResponseData:(NSData *)data Key:(NSString *)key{
    [_accessLock lock];
    
    NSString *cacheFilePath = [PathHelper pathForLibraryCacheAFNetWorkFile:[UAUtil md5:key withKey:UA_CACHE_FILE_KEY]];
    [data writeToFile:cacheFilePath atomically:YES];
    
    [_accessLock unlock];
}

- (NSData *)getCacheDataWithCacheKey:(NSString *)key{
    [_accessLock lock];
    
    NSString *cacheFilePath = [PathHelper pathForLibraryCacheAFNetWorkFile:[UAUtil md5:key withKey:UA_CACHE_FILE_KEY]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    BOOL filexist = [fm fileExistsAtPath:cacheFilePath];
    NSData *data = nil;
    if (filexist) {
        data = [NSData dataWithContentsOfFile:cacheFilePath];
    }
    
    [_accessLock unlock];
    return data;
}

- (void)removeCachedResponseDataWithKey:(NSString *)key{
    [_accessLock lock];
    
    NSString *cacheFilePath = [PathHelper pathForLibraryCacheAFNetWorkFile:[UAUtil md5:key withKey:UA_CACHE_FILE_KEY]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    BOOL filexist = [fm fileExistsAtPath:cacheFilePath];
    if (filexist) {
        [fm removeItemAtPath:cacheFilePath error:nil];
    }
    
    [_accessLock unlock];
}
@end
