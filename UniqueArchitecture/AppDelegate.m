//
//  AppDelegate.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/8.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "AppDelegate.h"
#import "UADB.h"
#import "HomePageViewController.h"

#import "UAUtil.h"

#import "UAHttpRequestModelManager.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
     _tabBarController= [[UATabBarController alloc] init];
    self.window.rootViewController = _tabBarController;
    [self.window makeKeyAndVisible];
    
    [self initShareSDK];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
   
}

#pragma mark - other method

- (void)initShareSDK
{
    
}
@end
