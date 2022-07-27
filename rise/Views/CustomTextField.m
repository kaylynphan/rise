//
//  CustomTextField.m
//  rise
//
//  Created by Kaylyn Phan on 7/27/22.
//

#import "CustomTextField.h"

@implementation CustomTextField

+ (UIEdgeInsets)customInsets {
    return UIEdgeInsetsMake(12, 12, 12, 12);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    return CGRectInset(rect, 16, 12);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    return CGRectInset(rect, 16, 12);
}

@end
