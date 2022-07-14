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
    
    [PoseImageView getTestJoint];
    
    self.jointSegments = @[
        [[JointSegment alloc] initWithJointA:Joint.leftHip withJointB:Joint.leftShoulder],
        [[JointSegment alloc] initWithJointA:Joint.leftShoulder withJointB:Joint.leftElbow],
        [[JointSegment alloc] initWithJointA:Joint.leftElbow withJointB:Joint.leftWrist]
    ];
}


+ (void)getTestJoint {
    NSLog([NSString stringWithFormat:@"Nose is %d", Joint.nose]);
}


     






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
