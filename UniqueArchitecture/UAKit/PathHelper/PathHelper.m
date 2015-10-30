//
//  PathHelper.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/13.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "PathHelper.h"

@implementation PathHelper



+ (BOOL)directoryExists:(NSString *)directoryPath{
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:directoryPath]) {
        if (![fm createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil]) {
            DBGLog(@"create library cache %@ failed..",directoryPath);
            return NO;
        }
    }
    return YES;
}

+ (NSString *)pathForLibraryCache{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [pathArray objectAtIndex:0];
}



+ (NSString *)pathForDocumentDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        return [paths objectAtIndex:0];
    }
    return nil;
}

+ (NSString *)pathForLibraryDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)pathForLibraryDirectoryCache{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

//AFNetWorkCache
+ (NSString *)pathForLibraryCacheAFNetWorkDocment{
    NSString *documentName = @"AFNetWorkCache";
    NSString *basePath = [self pathForLibraryCache];
    NSString *path = [NSString stringWithFormat:@"%@/%@",basePath,documentName];
    if ([self directoryExists:path]) {
        return path;
    }
    return nil;
}

+ (NSString *)pathForLibraryCacheAFNetWorkFile:(NSString *)filename{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self pathForLibraryCacheAFNetWorkDocment],filename];
    return filePath;
}

@end
