//
//  SelectedPoseTableFooter.m
//  rise
//
//  Created by Kaylyn Phan on 8/8/22.
//

#import "SelectedPoseTableFooter.h"
#import "../Styles.h"

@implementation SelectedPoseTableFooter
- (void)awakeFromNib {
    [super awakeFromNib];
    [Styles styleEnabledTextField:self.nameField];
    [Styles styleEnabledTextField:self.descriptionField];
    [Styles addGradientToButton:self.changeButton];
    [Styles addGradientToButton:self.doneButton];
}

- (IBAction)didTapChange:(id)sender {
    [self.vc change];
}

- (IBAction)didTapDone:(id)sender {
    if ([self.nameField.text isEqualToString:@""]) {
        [self.vc showEmptyNameAlert];
    } else if ([self.descriptionField.text isEqualToString:@""]) {
        [self.vc showEmptyDescriptionAlert];
    } else {
        [self.vc done];
    }
}

@end
