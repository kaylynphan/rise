//
//  WorkoutCell.h
//  rise
//
//  Created by Kaylyn Phan on 7/11/22.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import "ContainedButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WorkoutCellDelegate

- (void)didStartWorkout:(Workout *)workout;

@end

@interface WorkoutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIImageView *workoutImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) Workout *workout;
@property (weak, nonatomic) IBOutlet UILabel *stretchesLabel;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIView *startButtonBackground;


@property (nonatomic, weak) id<WorkoutCellDelegate> delegate;
- (IBAction)didTapStart:(id)sender;



@end

NS_ASSUME_NONNULL_END
