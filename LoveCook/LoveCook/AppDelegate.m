//
//  AppDelegate.m
//  LoveCook
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#import "CoreData+MagicalRecord.h"

#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    MyTabBarViewController *mvc=[[MyTabBarViewController alloc] init];
    self.window.rootViewController=mvc;
    
    [self initUM];
    [self initCoreData];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)initCoreData{
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"MyCook.sqlite"];

}

-(void)initUM{
    [UMSocialData setAppKey:@"5605094de0f55a0989000f25"];
    
    [UMSocialWechatHandler setWXAppId:@"wxc850607934f30c31" appSecret:@"12f4bd1e82ca8fae52022413b0efdeb9" url:nil];
     [self getWeiBoxInfo];
}
-(void)getWeiBoxInfo{
    AppDelegate *applction=[UIApplication sharedApplication].delegate;
    //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        
        applction.token=response.data[@"access_token"];
        
    }];
}




-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [UMSocialSnsService handleOpenURL:url];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [UMSocialSnsService handleOpenURL:url];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
