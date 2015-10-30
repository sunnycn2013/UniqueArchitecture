//
//  UAHttpRequest.h
//  UniqueArchitecture
//
//  Created by summer on 15/5/11.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPRequestOperation.h>
#import "UAHttpRequestModel.h"

@interface UAHttpRequest : NSObject{
    
}

@property (nonatomic,retain) AFHTTPRequestOperation  *requestOpetation;
@property (nonatomic,retain) UAHttpRequestModel          *requestModel;

+ (instancetype)manager;

- (void)GET:(NSString *)url parameters:(UAHttpRequestModel *)requestModel
                               success:(void (^)(UAHttpRequest *request, id responseObject))success
                               failure:(void (^)(UAHttpRequest *request, NSError *error))failure;

- (void)cancel;

@end
