//
//  YogaPoseCollectionViewCell.m
//  rise
//
//  Created by Kaylyn Phan on 8/4/22.
//

#import "YogaPoseCollectionViewCell.h"
#import "../Styles.h"

@implementation YogaPoseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CAGradientLayer *gradient = [Styles gradientForPoseCardView:self.cardView];
    [self.cardView.layer insertSublayer:gradient atIndex:0];
    self.cardView.layer.cornerRadius = 40.0;
    self.cardView.layer.masksToBounds = YES;
    [self sizeToFit];
}

- (IBAction)didTapSelectorButton:(id)sender {
}

@end
