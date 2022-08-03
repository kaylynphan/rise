//
//  Styles.h
//  rise
//
//  Created by Kaylyn Phan on 7/27/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Views/CustomTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface Styles : NSObject

+ (UIColor *)customPurpleColor;

+ (UIColor *)customBlueColor;

+ (CAGradientLayer *)buttonGradientForView:(UIView *)view;

+ (CAGradientLayer *)gradientForLargeView:(UIView *)view;

+ (void)addGradientToButton:(UIButton *)button;

+ (void)styleEnabledTextField:(CustomTextField *)textField;

+ (void)styleDisabledTextField:(CustomTextField *)textField;

+ (void)styleLargeLabel:(UILabel *)label;

+ (void)styleSmallLabel:(UILabel *)label;


@end

NS_ASSUME_NONNULL_END
