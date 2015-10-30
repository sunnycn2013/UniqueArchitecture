//
//  UASetRequestManager.h
//  UniqueArchitecture
//
//  Created by summer on 15/5/12.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UANetWork.h"

@interface UAHttpRequestModelManager : NSObject

+ (instancetype)manager;


/**
 *  获取server host
 *
 *  @param model model
 *
 *  @return serverURL
 */
+ (NSString *)getServerURL:(UAHttpRequestModel *)model;

/**
 *  rebuild common头请求信息
 *
 *  @param dic字典
 *
 *  @return rebuild后的字典
 */
+ (NSMutableDictionary *)requestCommonInfo;

/**
 *  计算HttpRequest 校验签名
 *
 *  @param dic 传入参数列表
 *
 *  @return 返回md5(key)的签名序列
 */
+ (NSString *)calculatingHttpRequestSignatureWithDic:(UAHttpRequestModel *)model;

/**
 *  计算request parameters
 *
 *  @param model 传入request model，拼接APP拼接common头字段，计算校验签名
 *
 *  @return 返回拼接common头、sign、请求参数的parameters字典
 */
+ (NSDictionary *)reBuildRequestParamtersWithModel:(UAHttpRequestModel *)model;

@end
