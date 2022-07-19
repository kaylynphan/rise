//
//  WorkoutCell.m
//  rise
//
//  Created by Kaylyn Phan on 7/11/22.
//

#import "WorkoutCell.h"
#import "ContainedButton.h"

@implementation WorkoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.cardView.backgroundColor = [UIColor grayColor];
    self.cardView.layer.cornerRadius = 40.0;
    self.cardView.layer.masksToBounds = YES;
    [self.titleLabel sizeToFit];
    
    self.circleView.layer.cornerRadius = 40;
    self.circleView.layer.masksToBounds = YES;
    self.circleView.layer.borderWidth = 1;
    self.circleView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.workoutImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    self.titleLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
    
    self.startButton.titleLabel.font = [UIFont fontWithName:@"Poppins-medium" size:16];
    [self.startButton sizeToFit];
    
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
