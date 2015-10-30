//
//  News.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/14.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "News.h"

@implementation News

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"city" : @"city",
             @"cityId" : @"cityid",
             @"time" : @"time",
             @"njd" : @"njd",
             @"tem" : @"tem",
             @"qy" : @"qy"
             };
}




- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    
    if (self){
    
    }
    return self;
}

@end
