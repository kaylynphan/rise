//
//  AppDelegate.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "AppDelegate.h"
#import <UserNotifications/UNUserNotificationCenter.h>
#import <UserNotifications/UNNotificationTrigger.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(  NSDictionary *)launchOptions {

    // complete Parse configuration
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

        NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
        NSString *appId = [dict objectForKey: @"appId"];
        NSString *clientKey = [dict objectForKey: @"clientKey"];
        
        configuration.applicationId = appId; // <- UPDATE
        configuration.clientKey = clientKey; // <- UPDATE
        configuration.server = @"https://parseapi.back4app.com";
    }];
    [Parse initializeWithConfiguration:config];
    
    // set system font
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Poppins-Regular" size:16.0]];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
