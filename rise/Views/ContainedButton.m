//
//  ContainedButton.m
//  rise
//
//  Created by Kaylyn Phan on 7/19/22.
//

#import "ContainedButton.h"

// A 'contained' button is a UIView with rounded corners that dynamically resizes to contain a UIButton with text.

@implementation ContainedButton

- (id) initWithText:(NSString *)text withFontSize:(CGFloat)fontSize {
    // create some default width and height
    self = [super initWithFrame:CGRectMake(0, 0, 70, 25)];
    self.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.titleLabel.text = text;
    self.button.titleLabel.font = [UIFont fontWithName:@"Poppins-regular" size:fontSize];
    self.button.titleLabel.textColor = [UIColor blackColor];
    [self.button sizeToFit];
    [self addSubview:self.button];

    // center X
    NSLayoutConstraint *buttonCenterHorizontalConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self addConstraint:buttonCenterHorizontalConstraint];
    
    // center Y
    NSLayoutConstraint *buttonCenterVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:buttonCenterVerticalConstraint];
    
    // set the size of self to be a bit larger than the size of the button
    //width
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.button attribute:NSLayoutAttributeWidth multiplier:1.25 constant:0];
    [self addConstraint:widthConstraint];
    
    //height
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.button attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [self addConstraint:heightConstraint];
    
    self.layer.cornerRadius = self.layer.frame.size.height / 2;
    self.layer.masksToBounds = YES;
    
    
    return self;
   
}

- (IBAction)whyDoINeedThis:(id)sender {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
