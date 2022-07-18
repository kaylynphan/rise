//
//  GuideViewController.h
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import <SRCountdownTimer/SRCountdownTimer-Swift.h>
#import "../Views/PoseImageView.h"
#import "rise-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface GuideViewController : UIViewController <SRCountdownTimerDelegate, VideoCaptureDelegate, PoseNetDelegate>

@property (weak, nonatomic) Workout *workout;
@property (weak, nonatomic) NSArray *poses;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet SRCountdownTimer *countdownTimer;
@property (weak, nonatomic) IBOutlet UILabel *poseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *poseImage;
@property (weak, nonatomic) IBOutlet PoseImageView *poseImageView;

@end

NS_ASSUME_NONNULL_END
