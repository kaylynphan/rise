//
//  PoseNetInput.m
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import "PoseNetInput.h"

@implementation PoseNetInput

static NSString *imageFeatureName = @"image";


- (instancetype) initWithImage:(CGImageRef *)image withSize:(CGSize *)size {
    self = [super init];
    self.imageFeature = image;
    self.imageFeatureSize = size;
    self.featureNames = [[NSMutableSet alloc] init];
    [self.featureNames addObject: imageFeatureName];
    return self;
}


- (MLFeatureValue * _Nullable) featureValueForName:(NSString *)featureName {
    if (featureName != imageFeatureName) {
        return nil;
    }
    // otherwise
    NSMutableDictionary *options = [[NSMutableDictionary init] alloc];
    //VNImageCropAndScaleOptionScaleFill = 2
    [options setObject:@(2) forKey:MLFeatureValueImageOptionCropAndScale];
    
    MLFeatureValue *result = [MLFeatureValue featureValueWithCGImage:self.imageFeature
                                            pixelsWide:self.imageFeatureSize->width
                                            pixelsHigh:self.imageFeatureSize->height
                                                     pixelFormatType:CGImageGetPixelFormatInfo(*(self.imageFeature))
                                            options:options
                                            error:nil]; // Not sure what to put here
     
    if (result) {
        return result;
    } else {
        return nil;
    }
}


@end
