//
//  CapturedJoint.h
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, Name) {
    nose,
    leftEye,
    rightEye,
    leftEar,
    rightEar,
    leftShoulder,
    rightShoulder,
    leftElbow,
    rightElbow,
    leftWrist,
    rightWrist,
    leftHip,
    rightHip,
    leftKnee,
    rightKnee,
    leftAnkle,
    rightAnkle,
    enumCount
};

static NSInteger *numberOfJoints = enumCount;

@interface CapturedJoint : NSObject
@property (weak, nonatomic) Name *name;
@property (assign, nonatomic) CGPoint *position;
@property



@end

NS_ASSUME_NONNULL_END
