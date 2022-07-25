//
//  NotificationManager.h
//  rise
//
//  Created by Kaylyn Phan on 7/25/22.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationManager : NSObject
@property (nonatomic, strong) UNNotificationSettings *settings;

- (void) fetchNotificationSettings;

- (void) requestAuthorization:(void(^)(BOOL))completion;

- (void) scheduleNotificationWithHour:(NSInteger *)hour withMinute:(NSInteger *)minute;


@end

NS_ASSUME_NONNULL_END
