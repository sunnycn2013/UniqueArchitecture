//
//  UARequestModel.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/11.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UAHttpRequestModel.h"

@implementation UAHttpRequestModel

+ (UAHttpRequestModel *)model{
    UAHttpRequestModel *requestModel = [[UAHttpRequestModel alloc] init];
    return requestModel;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //
    }
    return self;
}


@end
