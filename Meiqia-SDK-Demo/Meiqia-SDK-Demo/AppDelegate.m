//
//  AppDelegate.m
//  MQEcoboostSDK-test
//
//  Created by ijinmao on 15/11/11.
//  Copyright © 2015年 ijinmao. All rights reserved.
//

#import "AppDelegate.h"
#import <MeiQiaSDK/MQManager.h>
#import "MQServiceToViewInterface.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //推送注册
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert
                                                | UIUserNotificationTypeBadge
                                                | UIUserNotificationTypeSound
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
#else
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
#endif
    
//#error 请填写您的美洽 AppKey
    //cebf283b07b9df05889b2148b34c31b5
//009c6d3b9af54a81653c1982a1425e7b
//47b248431b919e46379226016d79187d 私有化
    //d21026430d2f3255be29428252880b6d
    //b92a682423d678e44faeb9d508920330
    //020a5a9f58c8f0e64ac98df631e706e8  alpha环境
    //d840152748fb1be270847656a4b35294 基富通
    //d70b21192f0f1e0843a9b5c2a7d2ed3a
    //1e50ad71cc22cf98400a934b4a0d3f0a socket测试
    [MQManager initWithAppkey:@"f3cdefb6d26664279197cee5547dd57f" completion:^(NSString *clientId, NSError *error) {
        if (!error) {
            NSLog(@"美洽 SDK：初始化成功");
        } else {
            NSLog(@"error:%@",error);
        }

        [MQServiceToViewInterface getUnreadMessagesWithCompletion:^(NSArray *messages, NSError *error) {
            NSLog(@">> unread message count: %d", (int)messages.count);
        }];
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [MQManager closeMeiqiaService];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [MQManager openMeiqiaService];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //上传设备deviceToken，以便美洽自建推送后，迁移推送
    [MQManager registerDeviceToken:deviceToken];
}

@end
