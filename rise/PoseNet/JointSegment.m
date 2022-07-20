//
//  JointSegment.m
//  rise
//
//  Created by Kaylyn Phan on 7/14/22.
//

#import "JointSegment.h"

@implementation JointSegment

- (instancetype)initWithJointA:(NSInteger *)jointA withJointB:(NSInteger *)jointB {
    self = [super init];
    self.jointA = jointA;
    self.jointB = jointB;
    return self;
}

@end
