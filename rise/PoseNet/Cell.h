//
//  Cell.h
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cell : NSObject

@property (assign, nonatomic) NSInteger yIndex;
@property (assign, nonatomic) NSInteger xIndex;

- (id) initWithY:(NSInteger *)y withX:(NSInteger *)x;

+ (Cell *) zero;



@end

NS_ASSUME_NONNULL_END
