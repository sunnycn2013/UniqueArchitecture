//
//  News.h
//  UniqueArchitecture
//
//  Created by summer on 15/5/14.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <JSONModel.h>

@interface News : JSONModel

@property (nonatomic,retain) NSNumber  *cityId;
@property (nonatomic,retain) NSString  *city;
@property (nonatomic,retain) NSString  *time;
@property (nonatomic,retain) NSString  *njd;
@property (nonatomic,retain) NSNumber  *tem;

@property (nonatomic,retain) NSURL  *qy;



@property (nonatomic,retain) NSString  *appCode;
@property (nonatomic,retain) NSString  *icon;
@property (nonatomic,assign) BOOL       needLogin;

@end
