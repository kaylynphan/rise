//
//  Workout.h
//  rise
//
//  Created by Kaylyn Phan on 7/12/22.
//

#import <Parse/Parse.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Workout : PFObject<PFSubclassing>
@property (nonatomic, weak) NSString *name;
@property (nonatomic, strong) NSMutableArray *stretches; // this is an array of indices
@property (nonatomic, weak) NSString *workoutDescription;
@property (nonatomic, weak)  User * _Nullable creator;

//- (instancetype) initWithName:(NSString *)name withArray:(NSArray *)array;

+ (void)createNewWorkoutWithPoses:(NSArray *)poses withName:(NSString *)name withDescription:(NSString *)description withCompletion:(PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
