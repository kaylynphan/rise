//
//  NotificationManager.m
//  rise
//
//  Created by Kaylyn Phan on 7/25/22.
//

#import "NotificationManager.h"
#import <UserNotifications/UNNotificationContent.h>
#import <Parse/Parse.h>

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
        if (error == nil) {
            NSLog(@"Notification authorization request succeeded!");
        } else {
            NSLog(@"Error requesting authorization");
        }
        [self fetchNotificationSettings];
        completion(granted);
    }];
}

- (void) scheduleNotificationWithHour:(NSInteger)hour withMinute:(NSInteger)minute {
    // set up date trigger
    NSDateComponents *components = [NSDateComponents new];
    components.hour = hour;
    components.minute = minute;
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
    // set up content
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Time to stretch!";
    if ([PFUser currentUser] != nil) {
        content.body = [NSString stringWithFormat:@"It's a new day %@, keep building stronger habits and complete your daily stretch.", [PFUser currentUser][@"displayName"]];
    } else {
        content.body = @"It's a new day, keep building stronger habits and complete your daily stretch.";
    }
    
    // set up notifications
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"StretchLocalNotification" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog([NSString stringWithFormat:@"Error adding notification request: %@", error.localizedDescription]);
        } else {
            NSLog([NSString stringWithFormat:@"Successfully added notification scheduled for %d:%d", hour, minute]);
        }
    }];
}

- (void)rescheduleNotificationWithHour:(NSInteger)hour withMinute:(NSInteger)minute {
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    [self scheduleNotificationWithHour:hour withMinute:minute];
}

@end
