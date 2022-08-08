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
    self.circleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
}

- (IBAction)didTapSelectorButton:(id)sender {
    if ([self.isSelectedPose isEqual:@YES]) {
        [self.selectorButton setImage:[UIImage imageNamed:@"Empty check"] forState:UIControlStateNormal];
        self.isSelectedPose = @NO;
    } else {
        [self.selectorButton setImage:[UIImage imageNamed:@"Filled check"] forState:UIControlStateNormal];
        self.isSelectedPose = @YES;
    }
    [self.createVC updateSelectedPoseAtIndex:self.row withVal:self.isSelectedPose];
}

@end
