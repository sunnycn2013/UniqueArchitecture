//
//  UAHttpRequest.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/11.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UAHttpRequest.h"

@implementation UAHttpRequest

+ (UAHttpRequest *)manager{
    return [[UAHttpRequest alloc] init];
}

- (void)GET:(NSString *)url parameters:(UAHttpRequestModel *)requestModel
                               success:(void (^)(UAHttpRequest *request, id responseObject))success
                               failure:(void (^)(UAHttpRequest *request, NSError *error))failure
{
    self.requestModel = requestModel;
    NSURLRequest *request = [self requestWithMethod:@"GET" requestModel:self.requestModel requesturl:url];
    _requestOpetation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    __block UAHttpRequest *weakself = self;

    [_requestOpetation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DBGLog(@"request url : %@", [operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        
        success(weakself,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DBGLog(@"Error: %@", [error description]);
        failure(weakself,error);
    }];
    [_requestOpetation start];
}

- (NSURLRequest *)requestWithMethod:(NSString *)method requestModel:(UAHttpRequestModel *)model requesturl:(NSString *)url{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[UAHttpRequestModelManager  getServerURL:model],url];
    NSDictionary *parameters = [UAHttpRequestModelManager reBuildRequestParamtersWithModel:model];
    NSMutableURLRequest *request = nil;
    NSError *error = nil;
    request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:parameters error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    return request;
}

- (void)cancel{
    [_requestOpetation pause];
    [_requestOpetation cancel];
}

@end
