//
//  NotificationManager.m
//  rise
//
//  Created by Kaylyn Phan on 7/25/22.
//

#import "NotificationManager.h"

@implementation NotificationManager

- (void) fetchNotificationSettings {
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.settings = settings;
        });
    }];
}

- (void) requestAuthorization:(void(^)(BOOL))completion {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"request succeeded!");
        }
        [self fetchNotificationSettings];
        completion(granted);
    }];
}

@end
