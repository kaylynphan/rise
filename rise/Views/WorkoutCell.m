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
    // remove highlight from table view cells
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cardView.layer.cornerRadius = 40.0;
    self.cardView.layer.masksToBounds = YES;
    [self.titleLabel sizeToFit];
    
    [self setupCircleView];
    [self.workoutImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    self.titleLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
    [self setupStartButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setupStartButton {
    self.startButton.titleLabel.font = [UIFont fontWithName:@"Poppins-medium" size:18];
    [self.startButton sizeToFit];
    self.startButtonBackground.layer.cornerRadius = 18;
    self.startButtonBackground.layer.masksToBounds = YES;
    self.startButtonBackground.layer.borderWidth = 1;
    self.startButtonBackground.layer.borderColor = [UIColor blackColor].CGColor;
    self.startButton.titleLabel.textColor = [UIColor blackColor];
}

- (void)setupCircleView {
    self.circleView.layer.cornerRadius = 40;
    self.circleView.layer.masksToBounds = YES;
    self.circleView.layer.borderWidth = 1;
    self.circleView.layer.borderColor = [UIColor blackColor].CGColor;
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
