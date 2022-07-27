//
//  Styles.h
//  rise
//
//  Created by Kaylyn Phan on 7/27/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Styles : NSObject

+ (CAGradientLayer *)buttonGradientForView:(UIView *)view;

+ (CAGradientLayer *)gradientForLargeView:(UIView *)view;

+ (void)addGradientToButton:(UIButton *)button;


@end

NS_ASSUME_NONNULL_END
