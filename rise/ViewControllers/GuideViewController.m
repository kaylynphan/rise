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
    
    self.countdownTimer.delegate = self;
    self.titleLabel.text = self.workout.name;
    [self updateLabels];
    
    NSLog(@"Now initializing PoseNet model");
    self.poseNet = [[PoseNet alloc] init];
    self.poseNet.delegate = self;
    
    self.videoCapture = [[VideoCapture alloc] init];
    NSLog(@"Now calling setupAndBeginCapturingVideoFrames");
    [self setupAndBeginCapturingVideoFrames];
    
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
    [self updateLabels];
}

- (void)updateLabels {
    if (exerciseNum < 6) {
        int *poseIndex = [[self.workout.stretches objectAtIndex:exerciseNum] intValue];
        YogaPose *pose = [self.poses objectAtIndex:poseIndex];
        self.poseLabel.text = pose.name;
        self.poseImage.image = pose.image;
        [self.countdownTimer startWithBeginingValue:30 interval:1];
    }
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

@end
