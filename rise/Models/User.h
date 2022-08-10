//
//  User.h
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN
/*
 This is a subclass of PFUser created to hold additional properties.
 */

@interface User : PFUser <PFSubclassing>

@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSNumber *preferredHour;
@property (nonatomic, strong) NSNumber *preferredMinute;
@property (nonatomic, strong) NSMutableArray *completionDates;
@property (assign) BOOL notificationsOn;

+ (User *)user;

@end

NS_ASSUME_NONNULL_END
