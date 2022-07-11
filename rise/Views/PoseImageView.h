//
//  PoseImageView.h
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PoseImageView : UIImageView

@property (nonatomic, strong) NSArray *jointSegments;

struct JointSegment {
    CGPoint *jointA;
    CGPoint *jointB;
};

@end

NS_ASSUME_NONNULL_END