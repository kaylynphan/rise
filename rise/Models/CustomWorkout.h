//
//  CustomWorkout.h
//  rise
//
//  Created by Kaylyn Phan on 8/5/22.
//

#import <Parse/Parse.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomWorkout : PFObject

@property (nonatomic, weak) User *creator;
@property (nonatomic, weak) NSString *name;
@property (nonatomic, weak) NSString *description;
@property (nonatomic, strong) NSMutableArray *stretches; // this is an array of indices

@end

NS_ASSUME_NONNULL_END
