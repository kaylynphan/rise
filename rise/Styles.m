//
//  Styles.m
//  rise
//
//  Created by Kaylyn Phan on 7/27/22.
//

#import "Styles.h"
#import "UIKit/UIKit.h"
#import "Views/CustomTextField.h"

@implementation Styles

+ (CAGradientLayer *)buttonGradientForView:(UIView *)view {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                           (id)[[UIColor colorWithRed:146.0/255.0f green:163.0/255.0f blue:253.0/255.0f alpha:1.0f] CGColor],
                           (id)[[UIColor colorWithRed:157.0/255.0f green:206.0/255.0f blue:255.0/255.0f alpha:1.0f] CGColor], nil];
    gradient.startPoint = CGPointMake(0, 1);
    gradient.endPoint = CGPointMake(1, 1);
    return gradient;
}

+ (CAGradientLayer *)gradientForLargeView:(UIView *)view {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                           (id)[[UIColor colorWithRed:146.0/255.0f green:163.0/255.0f blue:253.0/255.0f alpha:0.35f] CGColor],
                           (id)[[UIColor colorWithRed:157.0/255.0f green:206.0/255.0f blue:255.0/255.0f alpha:0.35f] CGColor], nil];
    gradient.startPoint = CGPointMake(1, 1);
    gradient.endPoint = CGPointMake(0, 0);
    return gradient;
}

+ (void)addGradientToButton:(UIButton *)button {
    button.titleLabel.font = [UIFont fontWithName:@"Poppins-medium" size:18];
    button.titleLabel.textColor = [UIColor whiteColor];
    CAGradientLayer *gradient = [Styles buttonGradientForView:button];
    [button.layer insertSublayer:gradient atIndex:0];
    button.layer.cornerRadius = 0.5 * button.frame.size.height;
    [button setClipsToBounds:YES];
    [button sizeToFit];
}

+ (void)styleEnabledTextField:(CustomTextField *)textField {
    textField.font = [UIFont fontWithName:@"Poppins-regular" size:16];
    textField.layer.cornerRadius = 12;
    textField.backgroundColor = [UIColor colorWithRed:234.0/255.0f green:240.0/255.0f blue:255.0/255.0f alpha:1.0f];
}

@end
