//
//  WorkoutCell.h
//  rise
//
//  Created by Kaylyn Phan on 7/11/22.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *workoutImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) Workout *workout;

@end

NS_ASSUME_NONNULL_END
