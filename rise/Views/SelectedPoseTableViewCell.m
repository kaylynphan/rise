//
//  SelectedPoseTableViewCell.m
//  rise
//
//  Created by Kaylyn Phan on 8/8/22.
//

#import "SelectedPoseTableViewCell.h"
#import "../Styles.h"

@implementation SelectedPoseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupCircleView];
    [Styles styleDisabledTextField:self.poseNameField];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setupCircleView {
    self.circleView.layer.cornerRadius = 40;
    self.circleView.layer.masksToBounds = YES;
    self.circleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
