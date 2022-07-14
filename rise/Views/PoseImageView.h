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

@end

NS_ASSUME_NONNULL_END
