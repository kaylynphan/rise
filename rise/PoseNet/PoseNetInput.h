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

@property (nonatomic) CGImageRef *imageFeature;
@property (nonatomic) CGSize *imageFeatureSize;
@property (strong, nonatomic) NSMutableSet *featureNames;

- (instancetype) initWithImage:(CGImageRef *)image withSize:(CGSize *)size;

- (MLFeatureValue * _Nullable) featureValueForName:(NSString *)featureName;










@end

NS_ASSUME_NONNULL_END
