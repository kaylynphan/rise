//
//  SelectedPoseTableFooter.m
//  rise
//
//  Created by Kaylyn Phan on 8/8/22.
//

#import "SelectedPoseTableFooter.h"

@implementation SelectedPoseTableFooter
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapChange:(id)sender {
    [self.vc change];
}

- (IBAction)didTapDone:(id)sender {
    [self.vc done];
}

@end
