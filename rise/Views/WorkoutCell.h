//
//  WorkoutCell.h
//  rise
//
//  Created by Kaylyn Phan on 7/11/22.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WorkoutCellDelegate

- (void)didStartWorkout:(Workout *)workout;

@end

@interface WorkoutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *workoutImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) Workout *workout;
@property (weak, nonatomic) IBOutlet UILabel *stretchesLabel;
@property (nonatomic, weak) id<WorkoutCellDelegate> delegate;
- (IBAction)didTapStart:(id)sender;


@end

NS_ASSUME_NONNULL_END
