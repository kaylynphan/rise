//
//  GuideViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "GuideViewController.h"
#import <SRCountdownTimer-Swift.h>
#import "YogaPose.h"
#import <SVGKit/SVGKit.h>
@import SRCountdownTimer;
#import "../Views/PoseImageView.h"
#import "CompletionViewController.h"
#import "../Styles.h"
#import "../Views/CustomTextField.h"

@interface GuideViewController ()

@property (strong, nonatomic) VideoCapture *videoCapture;
@property (strong, nonatomic)  PoseNet * _Nullable poseNet;
@property (weak, nonatomic) PoseBuilderConfiguration *poseBuilderConfiguration;
@property (strong, nonatomic) CGImageRef _Nullable currentFrame __attribute__((NSObject));
@property (assign) BOOL isPausedByUser;
@property (assign) BOOL isAutoPaused;
@property (weak, nonatomic) IBOutlet UIImageView *playIcon;
@property (weak, nonatomic) IBOutlet UIImageView *rewindIcon;
- (IBAction)didTapBackButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *pauseStatusLabel;
@property (weak, nonatomic) IBOutlet UIView *poseLabelBackground;
@property (weak, nonatomic) IBOutlet UIView *circleView;

@end

@implementation GuideViewController

static int exerciseNum = 0;
static int frameNum = 0;
static const int FRAME_ROTATION_RATE = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    [self.navigationController setNavigationBarHidden:NO];
    
    // set up countdown timer
    [self setupTimer];
    
    CustomTextField *workoutTitleField = [[CustomTextField alloc] init];
    workoutTitleField.text = self.workout.name;
    [Styles styleDisabledTextField:workoutTitleField];
    self.navigationItem.titleView = workoutTitleField;
    
    [self setupCircleView];

    [self updateLabels];
    [self.poseLabel setFont:[UIFont fontWithName:@"Poppins-medium" size:30]];

    self.poseLabelBackground.layer.cornerRadius = 16;
    self.poseLabelBackground.layer.masksToBounds = YES;
    
    //default
    self.isPausedByUser = NO;
    
    //NSLog(@"Now initializing PoseNet model");
    self.poseNet = [[PoseNet alloc] init];
    self.poseNet.delegate = self;
    
    self.videoCapture = [[VideoCapture alloc] init];
    //NSLog(@"Now calling setupAndBeginCapturingVideoFrames");
    [self setupAndBeginCapturingVideoFrames];
    
    [self.rewindIcon setFrame:CGRectMake(-77, self.playIcon.frame.origin.y, 77, 77)];
    
    self.pauseStatusLabel.font = [UIFont fontWithName:@"Poppins-bold" size:30];
}

- (void)setupCircleView {
    self.circleView.layer.cornerRadius = 40;
    self.circleView.layer.masksToBounds = YES;
    self.circleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
}

- (void)setupTimer {
    self.countdownTimer.delegate = self;
    [self.countdownTimer setLineColor:[UIColor colorWithWhite:0.75 alpha:0.5]];
    [self.countdownTimer setLabelFont:[UIFont fontWithName:@"Poppins-medium" size:65]];
}

- (void)setupAndBeginCapturingVideoFrames {
    [self.videoCapture setUpAVCaptureWithCompletion:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog([NSString stringWithFormat:@"Error: %@", error.localizedDescription]);
            NSLog(@"There is an error in setupAndBeginCapturingVideoFrames");
            return;
        }
        self.videoCapture.delegate = self;
        [self.videoCapture startCapturingWithCompletion:^{
            // empty
            NSLog(@"VideoCapture: startCapturing called");
        }];
        NSLog(@"Returning from setupAndBeginCapturingFrames");
    }];
}

- (void)timerDidEndWithSender:(SRCountdownTimer *)sender elapsedTime:(NSTimeInterval)elapsedTime {
    NSLog(@"Timer did end");
    exerciseNum++;
    if (exerciseNum >= self.workout.stretches.count) {
        [self finishWorkout];
    } else {
        [self updateLabels];
    }
}

- (void)updateLabels {
    if (exerciseNum < 6) {
        int *poseIndex = [[self.workout.stretches objectAtIndex:exerciseNum] intValue];
        YogaPose *pose = [self.poses objectAtIndex:poseIndex];
        self.poseLabel.text = pose.name;
        self.poseImage.image = [UIImage imageWithData:pose.imageData];
    }
    [self.countdownTimer startWithBeginingValue:30 interval:0.6];
}

// from VideoCaptureDelegate
- (void) videoCapture:(VideoCapture *)videoCapture didCaptureFrame:(CGImageRef)capturedImage {
    if (self.currentFrame != nil) {
        return;
    }
    CGImageRef image = capturedImage;
    if (capturedImage == nil) {
        // throw fatal error because captured image is null
    }
    self.currentFrame = image;
    [self.poseNet predict:image];
}

// from PoseNetDelegate
- (void) poseNet:(PoseNet *)poseNet didPredict:(PoseNetOutput *)predictions {
    CGImageRef currentFrame = self.currentFrame;
    if (currentFrame != self.currentFrame) {
        self.currentFrame = nil;
        return;
    }
    
    PoseBuilder *poseBuilder = [[PoseBuilder alloc] initWithOutput:predictions configuration:self.poseBuilderConfiguration inputImage:currentFrame];
    // here, there is a ternary operator checking for .single or .multiple. Let's only handle single
    // originally, we construct an array of poses.
    // here let's only an array of only one pose
    Pose *pose = [poseBuilder pose];
    NSMutableArray *poses = [[NSMutableArray alloc] init];
    [poses addObject:pose];
    
    [self.poseImageView showWithPoses:poses withFrame:currentFrame withBlock:^void(BOOL didDetectPose) {
        // don't run auto-pause feature on every single frame, this would be too erratic for smooth user experience
        if (frameNum % FRAME_ROTATION_RATE == 0) {
            if (!self.isPausedByUser) {
                if (!didDetectPose) {
                    //pause workout
                    [self pause];
                    [self turnOnAutoPause];
                }
                // if the user paused manually, with the intention of takinga  break or the like, they probably don't want the workout to start playing just because they were detected in the frame again
                if (didDetectPose && self.isAutoPaused) {
                    [self play];
                    [self turnOffAutoPause];
                }
            }
        }
    }];
    self.currentFrame = nil;
    frameNum++;
}

- (void)turnOnAutoPause {
    self.isAutoPaused = YES;
    [self.pauseStatusLabel setText:@"Step back into frame to continue..."];
    [self.pauseStatusLabel setHidden:NO];
}

- (void)turnOffAutoPause {
    self.isAutoPaused = NO;
    [self.pauseStatusLabel setHidden:YES];
}

- (void)turnOnManualPause {
    self.isPausedByUser = YES;
    [self.pauseStatusLabel setText:@"Press PLAY to continue..."];
    [self.pauseStatusLabel setHidden:NO];
    self.countdownTimer.counterLabel.text = @"";
    [self.playIcon setHidden:NO];
}

- (void)turnOffManualPause {
    self.isPausedByUser = NO;
    [self.pauseStatusLabel setHidden:YES];
    [self.playIcon setHidden:YES];
    self.countdownTimer.counterLabel.text = [NSString stringWithFormat:@"%ld", self.countdownTimer.currentCounterValue];
    [self.countdownTimer setIsLabelHidden:NO];
}

- (IBAction)didSingleTapTimer:(id)sender {
    if (self.isPausedByUser) {
        [self play];
        [self turnOffManualPause];
    } else {
        [self pause];
        [self turnOnManualPause];
    }
}

- (IBAction)didSwipeRight:(id)sender {
    if (self.countdownTimer.currentCounterValue > 28) {
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.rewindIcon.frame = CGRectMake(self.view.frame.size.width * 0.75, self.view.frame.size.height / 2 + 20, 70, 70);
        } completion:^(BOOL finished) {
            NSLog(@"Swipe animation complete");
        }];
        [UIView animateWithDuration:0.35 delay:0.35 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.rewindIcon.frame = CGRectMake(-70, self.view.frame.size.height / 2 + 20, 70, 70);
        } completion:^(BOOL finished) {
            NSLog(@"Swipe animation complete");
        }];
    } else {
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.rewindIcon.frame = CGRectMake(self.view.frame.size.width * 0.25, self.view.frame.size.height / 2 + 20, 70, 70);
        } completion:^(BOOL finished) {
            NSLog(@"Swipe animation complete");
        }];
        [UIView animateWithDuration:0.35 delay:0.35 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.rewindIcon.frame = CGRectMake(-70, self.view.frame.size.height / 2 + 20, 70, 70);
        } completion:^(BOOL finished) {
            NSLog(@"Swipe animation complete");
        }];
    }
    [self rewind];
}

- (void)pause {
    [self.countdownTimer pause];
}

- (void)play {
    [self.countdownTimer resume];
    frameNum = 0; // give user a 10-frame buffer before auto-pause takes effect (time to get back into position)
}

- (void)rewind {
    // if the workout just started, the user likely intends to go to the previous workout
    if (self.countdownTimer.currentCounterValue > 28) {
        if (exerciseNum > 0) {
            exerciseNum--;
            [self updateLabels];
        }
    } else {
        [self.countdownTimer startWithBeginingValue:30 interval:1];
    }
}

-(void)timerDidPauseWithSender:(SRCountdownTimer *)sender {
    //changing this temporarily for testing
    //[self finishWorkout];
}

-(void) finishWorkout {
    [self.videoCapture stopCapturingWithCompletion:^{
        NSLog(@"Stopped capturing frames");
    }];
    //CompletionViewController *completionVC = [[CompletionViewController alloc] initWithNibName:@"CompletionViewController" bundle:nil];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CompletionViewController *completionVC = [storyboard instantiateViewControllerWithIdentifier:@"CompletionViewController"];
    UINavigationController *navController = self.navigationController;
    //Get all view controllers in navigation controller currently
    NSMutableArray *controllers =[ [NSMutableArray alloc] initWithArray:navController.viewControllers] ;
    //Remove the last view controller
    [controllers removeLastObject];
    //set the new set of view controllers
    [navController setViewControllers:controllers];
    //Push a new view controller
    [navController pushViewController:completionVC animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 
    // some code for navigating to configurationViewController (not sure if we will use this here)
}
*/

@end
