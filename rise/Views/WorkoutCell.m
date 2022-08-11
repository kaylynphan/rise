//
//  WorkoutCell.m
//  rise
//
//  Created by Kaylyn Phan on 7/11/22.
//

#import "WorkoutCell.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "../Styles.h"

@implementation WorkoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // remove highlight from table view cells
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    CAGradientLayer *gradient = [Styles gradientForLargeView:self];
    [self.cardView.layer insertSublayer:gradient atIndex:0];
    
    self.cardView.layer.cornerRadius = 40.0;
    self.cardView.layer.masksToBounds = YES;
    [self.titleLabel sizeToFit];
    
    
    [self setupCircleView];
    [self.workoutImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    self.titleLabel.font = [UIFont fontWithName:@"Poppins-medium" size:28];
    [Styles addGradientToButton:self.startButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setupCircleView {
    self.circleView.layer.cornerRadius = 40;
    self.circleView.layer.masksToBounds = YES;
    self.circleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
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
