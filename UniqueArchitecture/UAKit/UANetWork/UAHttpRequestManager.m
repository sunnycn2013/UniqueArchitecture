//
//  UAHttpRequestQueue.m
//  UniqueArchitecture
//
//  Created by summer on 15/6/5.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UAHttpRequestManager.h"

@interface UAHttpRequestManager (){
    AFHTTPRequestOperationManager *_manager;
}

@end

@implementation UAHttpRequestManager

+ (instancetype)manager{
    return [[UAHttpRequestManager alloc] init];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.securityPolicy.allowInvalidCertificates = YES;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];//设置相应内容类型
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

- (void)setAllowInvalidCertificates:(BOOL)allowInvalidCertificates{
    _manager.securityPolicy.allowInvalidCertificates = allowInvalidCertificates;
}

- (void)GET:(NSString *)url parameters:(UAHttpRequestModel *)request
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[UAHttpRequestModelManager getServerURL:request],url];
    NSDictionary *parameters = [UAHttpRequestModelManager reBuildRequestParamtersWithModel:request];
    //return [_manager GET:urlString parameters:parameters success:success failure:failure];
    [_manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        DBGLog(@"request url : %@",[operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failure(operation,error);
    }];
}

- (void)POST:(NSString *)url parameters:(UAHttpRequestModel *)request
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[UAHttpRequestModelManager getServerURL:request],url];
    NSDictionary *parameters = [UAHttpRequestModelManager reBuildRequestParamtersWithModel:request];
    [_manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        DBGLog(@"request url : %@",[operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failure(operation,error);
    }];
}

- (void)POST:(NSString *)url parameters:(UAHttpRequestModel *)request
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[UAHttpRequestModelManager getServerURL:request],url];
    NSDictionary *parameters = [UAHttpRequestModelManager reBuildRequestParamtersWithModel:request];
    [_manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        block(formData);
    } success:^(AFHTTPRequestOperation *operation, id responseObject){
        DBGLog(@"request url : %@",[operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failure(operation,error);
    }];
}
@end
