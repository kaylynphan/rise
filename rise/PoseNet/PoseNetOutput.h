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
@property (strong, nonatomic) MLMultiArray *backwardDisplacementMap;
@property (strong, nonatomic) MLMultiArray *forwardDisplacementMap;
@property (nonatomic) struct CGSize *modelInputSize;
@property (assign, nonatomic) NSInteger *modelOutputStride;

- (id) initWithPrediction:(struct MLFeatureProvider *)prediction
       withModelInputSize:(CGSize *)modelInputSize
       withModelOutputStride:(NSInteger *)modelOutputStride;

- (NSInteger *) height;

- (NSInteger *) width;

- (CGPoint * _Nullable) position:(CapturedJoint *)jointName withCell:(Cell *_Nullable)cell;

- (Cell * _Nullable) cell:(CGPoint *)position;

-

#pragma mark - Utility and accessor methods









@end

//NS_ASSUME_NONNULL_EN
