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
    
    self.jointSegments = @[
        [[JointSegment alloc] initWithJointA:Joint.nose withJointB:Joint.leftEye],
        [[JointSegment alloc] initWithJointA:Joint.leftShoulder withJointB:Joint.leftElbow],
        [[JointSegment alloc] initWithJointA:Joint.leftElbow withJointB:Joint.leftWrist]
    ];
    
    [self runTests];
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
