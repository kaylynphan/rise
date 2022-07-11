//
//  Cell.m
//  rise
//
//  Created by Kaylyn Phan on 7/7/22.
//

#import "Cell.h"

@implementation Cell

- (id) initWithY:(NSInteger *)y withX:(NSInteger *)x {
    self = [super init];
    self.yIndex = *y;
    self.xIndex = *x;
    return self;
}

+ (Cell *) zero {
    Cell *zero = [[Cell alloc] initWithY:@(0) withX:@(0)];
    return zero;
}

@end
