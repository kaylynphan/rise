//
//  Workout.m
//  rise
//
//  Created by Kaylyn Phan on 7/12/22.
//

#import "Workout.h"

@implementation Workout

+ (nonnull NSString *)parseClassName {
    return @"Workout";
}

+ (void)createNewWorkoutWithPoses:(NSArray *)poses withName:(NSString *)name withDescription:(NSString *)description withCompletion:(PFBooleanResultBlock  _Nullable)completion {
    Workout *newWorkout = [Workout new];
    newWorkout.creator = [User currentUser];
    newWorkout.stretches = poses;
    newWorkout.name = name;
    newWorkout.workoutDescription = description;
    [newWorkout saveInBackgroundWithBlock: completion];
}

@end
