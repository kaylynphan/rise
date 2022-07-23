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

@interface GuideViewController ()

@property (strong, nonatomic) VideoCapture *videoCapture;
@property (strong, nonatomic)  PoseNet * _Nullable poseNet;
@property (weak, nonatomic) PoseBuilderConfiguration *poseBuilderConfiguration;
@property (strong, nonatomic) CGImageRef _Nullable currentFrame __attribute__((NSObject));
@property (assign) BOOL isPaused;
@property (weak, nonatomic) IBOutlet UIImageView *playIcon;
@property (weak, nonatomic) IBOutlet UIImageView *rewindIcon;

@end

@implementation GuideViewController

static int exerciseNum = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //customize back button
    //self.backButton.titleView.tintColor = [UIColor blackColor];
    self.backButton.backBarButtonItem.tintColor = [UIColor blackColor];

    //[PoseImageView getJoint]; //test success!!
    
    // set up countdown timer
    self.countdownTimer.delegate = self;
    [self.countdownTimer setLineColor:[UIColor greenColor]];
    //[self.countdownTimer setLineWidth:15];
    [self.countdownTimer setLabelFont:[UIFont fontWithName:@"Poppins-medium" size:65]];
    //[self.countdownTimer setLabelTextColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    //[self.countdownTimer setBackgroundColor:[UIColor clearColor]];
    
    
    self.titleLabel.text = self.workout.name;
    [self updateLabels];
    self.isPaused = NO;
    
    NSLog(@"Now initializing PoseNet model");
    self.poseNet = [[PoseNet alloc] init];
    self.poseNet.delegate = self;
    
    self.videoCapture = [[VideoCapture alloc] init];
    NSLog(@"Now calling setupAndBeginCapturingVideoFrames");
    [self setupAndBeginCapturingVideoFrames];
    
    [self.rewindIcon setFrame:CGRectMake(-77, self.playIcon.frame.origin.y, 77, 77)];
    
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
        [self performSegueWithIdentifier:@"guideToCompletionSegue" sender:self];
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
    [self.countdownTimer startWithBeginingValue:30 interval:1];
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
    
    [self.poseImageView showWithPoses:poses withFrame:currentFrame];
    self.currentFrame = nil;
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

- (IBAction)didSingleTapTimer:(id)sender {
    if (self.isPaused) {
        [self play];
    } else {
        [self pause];
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
    [self.countdownTimer setLineColor:[UIColor yellowColor]];
    [self.countdownTimer pause];
    self.isPaused = YES;
}

- (void)play {
    [self.countdownTimer setLineColor:[UIColor greenColor]];
    [self.countdownTimer resume];
    self.isPaused = NO;
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
    /*
    //changing this temporarily for testing
    self.countdownTimer.counterLabel.text = @"";
    [self.playIcon setHidden:NO];
     */
    [self performSegueWithIdentifier:@"guideToCompletionSegue" sender:nil];
}

-(void)timerDidResumeWithSender:(SRCountdownTimer *)sender {
    [self.playIcon setHidden:YES];
    self.countdownTimer.counterLabel.text = [NSString stringWithFormat:@"%ld", self.countdownTimer.currentCounterValue];
    [self.countdownTimer setIsLabelHidden:NO];
}

@end
