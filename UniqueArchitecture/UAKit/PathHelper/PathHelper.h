//
//  PathHelper.h
//  UniqueArchitecture
//
//  Created by summer on 15/5/13.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathHelper : NSObject

+ (NSString *)pathForDocumentDirectory;


//Library
+ (NSString *)pathForLibraryDirectory;

//Library cache
+ (NSString *)pathForLibraryDirectoryCache;

/**
 *  Library/Cache/AFNetWorkCache
 *
 *  @return AFNetWorkCache path
 */
+ (NSString *)pathForLibraryCacheAFNetWorkDocment;
+ (NSString *)pathForLibraryCacheAFNetWorkFile:(NSString *)filename;

@end
