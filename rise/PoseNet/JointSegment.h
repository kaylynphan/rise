//
//  JointSegment.h
//  rise
//
//  Created by Kaylyn Phan on 7/14/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JointSegment : NSObject

@property (assign, nonatomic) NSInteger *jointA;
@property (assign, nonatomic) NSInteger *jointB;

- (instancetype)initWithJointA:(NSInteger *)jointA withJointB:(NSInteger *)jointB;
 
@end

NS_ASSUME_NONNULL_END
