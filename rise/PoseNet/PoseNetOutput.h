//
//  PoseNetOutput.h
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import <Foundation/Foundation.h>
#import <CoreML/MLMultiArray.h>
#import <CoreML/MLFeatureProvider.h>
#import "CapturedJoint.h"
#import "Cell.h"

//NS_ASSUME_NONNULL_BEGIN

@interface PoseNetOutput : NSObject

@property (strong, nonatomic) MLMultiArray *heatmap;
@property (strong, nonatomic) MLMultiArray *offsets;

// only used for multiple poses
// @property (strong, nonatomic) MLMultiArray *backwardDisplacementMap;

// only used for multiple poses
//@property (strong, nonatomic) MLMultiArray *forwardDisplacementMap;
@property (nonatomic) CGSize *modelInputSize;
@property (assign, nonatomic) NSInteger *modelOutputStride;

- (id) initWithPrediction:(MLFeatureValue *)prediction
       withModelInputSize:(CGSize *)modelInputSize
       withModelOutputStride:(NSInteger *)modelOutputStride;

- (NSInteger *) height;

- (NSInteger *) width;

- (CGPoint * _Nullable) position:(Name *_Nullable)jointName withCell:(Cell * _Nullable)cell;

- (Cell * _Nullable) cell:(CGPoint *_Nullable)position;

- (CGVector * _Nullable) offset:(Name * _Nullable)jointName withCell:(Cell * _Nullable)cell;

- (double) confidence:(Name * _Nullable)jointName withCell:(Cell * _Nullable)cell;

- (CGVector *) backwardDisplacement:(NSInteger *)edgeIndex withCell:(Cell * _Nullable)cell;

- (MLMultiArray * _Nullable) multiArrayValue:(NSString *)feature;

// TODO: MLFeatureProvider extension: multiArrayValue()
// TODO: MLMultiArray extension: subscript



@end

//NS_ASSUME_NONNULL_EN
