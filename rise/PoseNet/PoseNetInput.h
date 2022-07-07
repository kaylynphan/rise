//
//  PoseNetInput.h
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import <Foundation/Foundation.h>
#import <CoreML/MLFeatureProvider.h>
#import <Vision/Vision.h>

NS_ASSUME_NONNULL_BEGIN

@interface PoseNetInput : NSObject <MLFeatureProvider>

@property (nonatomic) struct CGImage *imageFeature;
@property (nonatomic) struct CGSize *imageFeatureSize;
@property (strong, nonatomic) NSMutableSet *featureNames;

- (id) init:(struct CGImage *)image withSize:(struct CGSize *)size;

- (MLFeatureValue * _Nullable) featureValueForName:(NSString *)featureName;










@end

NS_ASSUME_NONNULL_END
