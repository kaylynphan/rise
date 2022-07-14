//
//  PoseImageView.m
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import "PoseImageView.h"
#import "JointSegment.h"
#import "rise-Swift.h"


@implementation PoseImageView

/*
+ (NSArray *)jointSegments {
    return [
            [JointSegment initWithJointA:Joint.leftHip withJointB:Joint.leftShoulder]
    ];
}
 */

+ (void)getJoint {
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
