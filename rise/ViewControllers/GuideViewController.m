//
//  GuideViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "GuideViewController.h"
#import <SRCountdownTimer-Swift.h>
#import "Pose.h"
@import SRCountdownTimer;


@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.workout.name;
    Pose *firstPose = [self.workout.stretches objectAtIndex:0];
    self.poseLabel.text = firstPose.name;
    self.poseImage.image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:firstPose.imageURL]];
    [self.countdownTimer startWithBeginingValue:30 interval:1];

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
