//
//  UASetRequestManager.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/12.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UAHttpRequestModelManager.h"
#import "UAUtil.h"

#define hostUrl               @"http://www.baidu.com/"
#define promationUrl          @"http://www.baidu.com/"
#define ccguoHost             @"http://ccguo.github.io/"

#define MD5_SIGNNATURE_KEY    @"SDGHJKYTYTHJNB^%$#@!@#"

@interface UAHttpRequestModelManager (){
    
}

@end

@implementation UAHttpRequestModelManager

+ (instancetype)manager{
    return [[UAHttpRequestModelManager alloc] init];
}

+ (NSString *)getServerURL:(UAHttpRequestModel *)model{
    NSString *serverURL = hostUrl;
    
    switch (model.servicesType) {
        case HOST_URL_DEFAULT:
            serverURL = hostUrl;
            break;
        case HOST_URL_PROMATION:
            serverURL = promationUrl;
            break;
        default:
            break;
    }
    return serverURL;
}

+ (NSMutableDictionary *)requestCommonInfo{
    NSMutableDictionary *commonInfoDic = [[NSMutableDictionary alloc] init];
    [commonInfoDic setObject:[UAUtil getDeviceType] forKey:@"DeviceType"];
    [commonInfoDic setObject:[UAUtil getNetWorkType] forKey:@"NetWork"];
    [commonInfoDic setObject:[UAUtil getOSVersion] forKey:@"osVersion"];
    [commonInfoDic setObject:[UAUtil getClientVersion] forKey:@"clientVersion"];
    [commonInfoDic setObject:[UAUtil getClientBuild] forKey:@"build"];
    [commonInfoDic setObject:[UAUtil getScreenSize] forKey:@"screenSize"];
    [commonInfoDic setObject:[UAUtil getAdvertisingIdentifier] forKey:@"idfa"];
    return commonInfoDic;
}

+ (NSString *)calculatingHttpRequestSignatureWithDic:(UAHttpRequestModel *)model{
    NSString *paraString = [UAUtil stringFromDic:model.params];
    NSString *verificationString = [NSString stringWithFormat:@"servicesName=%@,paraString=%@,key=%@",
                                    model.servicesName,paraString,MD5_SIGNNATURE_KEY];
    return [UAUtil md5:verificationString withKey:MD5_SIGNNATURE_KEY];
}

+ (NSDictionary *)reBuildRequestParamtersWithModel:(UAHttpRequestModel *)model{
    NSDictionary *commonInfo = [UAHttpRequestModelManager requestCommonInfo];
    NSString *sign = [UAHttpRequestModelManager calculatingHttpRequestSignatureWithDic:model];    
    
    NSMutableDictionary *dics = [[NSMutableDictionary alloc] init];
    [dics setObject:[UAUtil stringFromDic:commonInfo] forKey:@"common"];
    [dics setValue:[UAUtil stringFromDic:model.params] forKey:@"body"];
    [dics setValue:sign forKey:@"sign"];
    return dics;
}

@end
