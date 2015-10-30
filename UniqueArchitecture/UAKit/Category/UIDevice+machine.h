//
//  UIDevice+machine.h
//  UniqueArchitecture
//
//  Created by summer on 15/6/5.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIDevice (machine)
/**
 *  获取设备名称
 *
 *  @return machine name
 */
- (NSString *)machine;

/**
 *  获取网卡地址
 *
 *  @return address
 */
- (NSString *) macaddress;

@end
