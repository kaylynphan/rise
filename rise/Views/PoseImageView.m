//
//  PoseImageView.m
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import "PoseImageView.h"
#import "../PoseNet/JointSegment.h"
#import "rise-Swift.h"
#import <CoreGraphics/CGImage.h>
#import <CoreGraphics/CGContext.h>
#import <UIKit/UIKit.h>

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

- (void)showWithPoses:(NSArray *)poses withFrame:(CGImageRef)frame withBlock:(void(^)(BOOL didDetectPose))block {
    CGFloat frameWidth = CGImageGetWidth(frame); // frame is working!!!
    CGFloat frameHeight = CGImageGetHeight(frame);
    CGSize dstImageSize = CGSizeMake(frameWidth, frameHeight);
    
    // configure drawing context
    UIGraphicsBeginImageContextWithOptions(dstImageSize, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // render camera feed
    CGContextSaveGState(context);
    CGContextScaleCTM(context, 1, -1);
    CGRect drawingRect = CGRectMake(0, -1 * frameHeight, frameWidth, frameHeight);
    CGContextDrawImage(context, drawingRect, frame);
    CGContextRestoreGState(context);
    
    // draw segments
    for (Pose *pose in poses) {
        for (JointSegment *segment in self.jointSegments) {
            int indexA = segment.jointA;
            int indexB = segment.jointB;
            Joint *jointA = [pose getJointWithIndex:indexA];
            Joint *jointB = [pose getJointWithIndex:indexB];
            
            if (jointA.isValid && jointB.isValid) {
                //NSLog([NSString stringWithFormat:@"Segment from Index: %d, Joint %d to Index: %d, Joint %d", indexA, jointA.name, indexB, jointB.name]);
                [self drawLineWithParentJoint:jointA withChildJoint:jointB withCGContext:context];
            }
        }
        
        int jointsDetected = 0;
        
        // draw joints
        for (Joint *joint in pose.joints) {
            // ignore the first 4 joints (facial joints)
            if (joint.name > 4) {
                if (joint.isValid) {
                    [self drawWithCircle:joint withCGContext:context];
                    jointsDetected++;
                }
            }
        }
        
        // if less than 5 non-facial joints are detected, it would be safe to say that a valid pose was not detected
        // likely the user walked off the screen
        if (jointsDetected < 5) {
            block(NO);
        } else {
            block(YES);
        }
    }
    UIImage *dstImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = dstImage;
}

- (void) drawLineWithParentJoint:(Joint *)parentJoint withChildJoint:(Joint *)childJoint withCGContext:(CGContextRef)cgContext {
    CGContextSetStrokeColorWithColor(cgContext, UIColor.blackColor.CGColor);
    CGContextSetLineWidth(cgContext, 2.0);
    CGContextMoveToPoint(cgContext, parentJoint.position.x, parentJoint.position.y);
    CGContextAddLineToPoint(cgContext, childJoint.position.x, childJoint.position.y);
    CGContextStrokePath(cgContext);
}

- (void) drawWithCircle:(Joint *)joint withCGContext:(CGContextRef)cgContext {
    CGContextSetFillColorWithColor(cgContext, UIColor.blackColor.CGColor);
    CGFloat jointRadius = 4.0;
    CGRect rectangle = CGRectMake(joint.position.x - jointRadius, joint.position.y - jointRadius, jointRadius * 2, jointRadius * 2);
    CGContextAddEllipseInRect(cgContext, rectangle);
    CGContextDrawPath(cgContext, kCGPathFill);
}

- (void)runTests {
}

@end
