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


@interface GuideViewController ()

@end

@implementation GuideViewController

static int exerciseNum = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.countdownTimer.delegate = self;
    self.titleLabel.text = self.workout.name;
    [self updateLabels];
    
    // initial labels and images
    /*
    YogaPose *firstPose = [self.workout.stretches objectAtIndex:0];
    self.poseLabel.text = firstPose.name;
    self.poseImage.image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:firstPose.imageURL]];
    [self.countdownTimer startWithBeginingValue:30 interval:1];
     */
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
        self.poseImage.image = [SVGKImage imageWithContentsOfURL:pose.imageURL].UIImage;
        [self.countdownTimer startWithBeginingValue:30 interval:1];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
