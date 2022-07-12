//
//  Workout.h
//  rise
//
//  Created by Kaylyn Phan on 7/12/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Workout : PFObject<PFSubclassing>
@property (nonatomic, weak) NSString *name;
@property (nonatomic, strong) NSMutableArray *stretches;

//- (instancetype) initWithName:(NSString *)name withArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
