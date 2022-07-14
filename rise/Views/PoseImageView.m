//
//  PoseImageView.m
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import "PoseImageView.h"
#import "../PoseNet/JointSegment.h"
#import "rise-Swift.h"

@implementation PoseImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.jointSegments = @[
        //left joints
        [[JointSegment alloc] initWithJointA:Joint.leftHip withJointB:Joint.leftShoulder],
        [[JointSegment alloc] initWithJointA:Joint.leftShoulder withJointB:Joint.leftElbow],
        [[JointSegment alloc] initWithJointA:Joint.leftElbow withJointB:Joint.leftWrist],
        [[JointSegment alloc] initWithJointA:Joint.leftHip withJointB:Joint.leftKnee],
        [[JointSegment alloc] initWithJointA:Joint.leftKnee withJointB:Joint.leftAnkle],
        
        //right joints
        [[JointSegment alloc] initWithJointA:Joint.rightHip withJointB:Joint.rightShoulder],
        [[JointSegment alloc] initWithJointA:Joint.rightShoulder withJointB:Joint.rightElbow],
        [[JointSegment alloc] initWithJointA:Joint.rightElbow withJointB:Joint.rightWrist],
        [[JointSegment alloc] initWithJointA:Joint.rightHip withJointB:Joint.rightKnee],
        [[JointSegment alloc] initWithJointA:Joint.rightKnee withJointB:Joint.rightAnkle],
        
        //cross overs
        [[JointSegment alloc] initWithJointA:Joint.leftShoulder withJointB:Joint.rightShoulder],
        [[JointSegment alloc] initWithJointA:Joint.leftHip withJointB:Joint.rightHip],
    ];
    [self runTests];
}

- (void)showWithPoses:(NSArray *)poses withFrame:(CGImageRef *)frame {
    CGFloat *width = (CGFloat)[CGImageGetWidth(*frame)];
    CGFloat *height = (CGFloat)[CGImageGetHeight(*frame)];
    CGSize *dstImageSize = [CGSizeMake(*width, *height)];
    
}


- (void)runTests {
    // Test 1: PASS!!
    /*
    NSLog([NSString stringWithFormat:@"Nose is %d", Joint.nose]);
    */
    
    // Test 2: PASS!!
    /*
    NSLog(@"Segments:");
    for (JointSegment *segment in self.jointSegments) {
        NSLog(@"JointA: %d, JointB: %d", segment.jointA, segment.jointB);
    }
     */
}


     






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
