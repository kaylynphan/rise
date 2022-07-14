//
//  WorkoutCell.m
//  rise
//
//  Created by Kaylyn Phan on 7/11/22.
//

#import "WorkoutCell.h"

@implementation WorkoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.cardView.backgroundColor = [UIColor grayColor];
    self.cardView.layer.cornerRadius = 40.0;
    self.cardView.layer.masksToBounds = YES;
    [self.titleLabel sizeToFit];
    
    self.workoutImageView.layer.cornerRadius = 50;
    self.workoutImageView.layer.masksToBounds = YES;
    self.workoutImageView.layer.borderWidth = 1;
    self.workoutImageView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.workoutImageView setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapStart:(id)sender {
    NSLog(@"Start button tapped!");
    Workout *workoutToSend = self.workout;
    if (self.delegate != nil) {
        NSLog(@"Telling delegate to start workout!");
        [self.delegate didStartWorkout:workoutToSend];
    }
}
@end
