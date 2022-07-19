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

- (void)showWithPoses:(NSArray *)poses withFrame:(CGImageRef)frame {
    CGFloat frameWidth = CGImageGetWidth(frame);
    CGFloat frameHeight = CGImageGetHeight(frame);
    CGSize dstImageSize = CGSizeMake(frameWidth, frameHeight);
    
    UIGraphicsImageRendererFormat *dstImageFormat = [[UIGraphicsImageRendererFormat alloc] init];
    
    dstImageFormat.scale = 1;
    
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:dstImageSize format:dstImageFormat];
    
    // call draw()
    UIImage *dstImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        NSLog(@"PoseImageView drawWithImage is being called");
        [self drawWithImage:frame withCGContext:rendererContext.CGContext];
        for (Pose *pose in poses) {
            for (JointSegment *segment in self.jointSegments) {
                int indexA = segment.jointA;
                int indexB = segment.jointB;
                Joint *jointA = [pose getJointWithIndex:indexA];
                Joint *jointB = [pose getJointWithIndex:indexB];
                
                if (jointA.isValid && jointB.isValid) {
                    [self drawLineWithParentJoint:jointA withChildJoint:jointB withCGContext:rendererContext.CGContext];
                }
            }
            for (Joint *joint in pose.joints) {
                if (joint.isValid) {
                    [self drawWithCircle:joint withCGContext:rendererContext.CGContext];
                }
            }
        }
    }];
}

- (void)drawWithImage:(CGImageRef)image withCGContext:(CGContextRef)cgContext {
    CGContextSaveGState(cgContext);
    CGContextScaleCTM(cgContext, 1.0, -1.0);
    CGRect drawingRect = CGRectMake(0, -1 * CGImageGetHeight(image), CGImageGetWidth(image), CGImageGetHeight(image));
    CGContextDrawImage(cgContext, drawingRect, image);
    CGContextRestoreGState(cgContext);
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
