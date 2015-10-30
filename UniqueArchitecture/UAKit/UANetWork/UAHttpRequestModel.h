//
//  UARequestModel.h
//  UniqueArchitecture
//
//  Created by summer on 15/5/11.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum HOST_URL_TYPE{
    HOST_URL_DEFAULT = 0,
    HOST_URL_PROMATION, //促销
    HOST_URL_CCGUO,
    HOST_URL_ip
}HOST_URL_TYPE;

@interface UAHttpRequestModel : NSObject

@property(nonatomic,retain) NSMutableDictionary  *params;

/**
 *  post get 2.0接入
 */
//@property(nonatomic,assign) NSString             *method;

/**
 *  host 地址
 */
@property(nonatomic,assign) HOST_URL_TYPE        servicesType;

/**
 *  service 名称，接口名
 */
@property(nonatomic,retain) NSString             *servicesName;

/**
 *  签名
 */
//@property(nonatomic,retain) NSString             *sign;


+ (UAHttpRequestModel *)model;
@end
