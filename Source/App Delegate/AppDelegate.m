//
//  AppDelegate.m
//  xkcd Open Source
//
//  Created by Mike on 5/14/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "AppDelegate.h"
#import "ComicListViewController.h"
#import "ApplicationController.h"
#import "Assembler.h"
#import <InsertFramework/InsertFramework.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)sharedAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - App life cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[InsertManager sharedManager] initSDK:@"6c181c318fb211527d58c8a9d051819cb71ae8af849efcd6cc7c2406f2bbad102895af9bddd5f30dea731c6dbc00647792bede7e2cdac85b9c9c54ba758baed9.664770ece9ce62db22ec6994c57d2b08.a25de665d12d7374bf5c2f298b91507a3e87557385da9aa819787e968d8529fa"
                               companyName: @"pendotest" 
                                initParams: nil];
    
    //[[InsertManager sharedManager] setUserAttributes:@{@"permissionLevel" : @"user",@"isTrial" : @"false"}];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    if (application.applicationIconBadgeNumber > 0) {
        application.applicationIconBadgeNumber = 0;
    }

    [[ApplicationController sharedInstance] handleAppLaunch];

    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ComicListViewController new]];;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Whenever the app becomes active clear the badge.
    if (application.applicationIconBadgeNumber > 0) {
        application.applicationIconBadgeNumber = 0;
    }
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;
{
    if ([[url scheme] containsString:@"insert"]) {
        [[InsertManager sharedManager] initWithUrl:url];
        return YES;
    }
    //  your code here ...
    return YES;
}




#pragma mark - Push notifications

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[ApplicationController sharedInstance] handlePushRegistrationWithTokenData:deviceToken];
}

@end
