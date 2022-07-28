//
//  PoseImageView.h
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import <UIKit/UIKit.h>
#import "rise-Swift.h"
#import "JointSegment.h"

NS_ASSUME_NONNULL_BEGIN

@interface PoseImageView : UIImageView

@property (strong, nonatomic) NSArray *jointSegments;

- (void)runTests;

- (void)showWithPoses:(NSArray *)poses withFrame:(CGImageRef)frame withBlock:(void(^)(BOOL didDetectPose))block;

- (void) drawWithImage:(CGImageRef)image withCGContext:(CGContextRef)cgContext;

- (void) drawLineWithParentJoint:(Joint *)parentJoint withChildJoint:(Joint *)childJoint withCGContext:(CGContextRef)cgContext;

- (void) drawWithCircle:(Joint *)joint withCGContext:(CGContextRef)cgContext;

@end

NS_ASSUME_NONNULL_END
