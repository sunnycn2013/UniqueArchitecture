//
//  UAInternationalControl.m
//  UniqueArchitecture
//
//  Created by summer on 15/6/17.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UAInternationalControl.h"

@implementation UAInternationalControl

+ (NSString *)getLocalizableStringWithKey:(NSString *)key{
    NSString *str = NSLocalizedString(key, @"");
    return str;
}
@end
