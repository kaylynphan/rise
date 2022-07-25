//
//  GalleryViewHeader.m
//  rise
//
//  Created by Kaylyn Phan on 7/14/22.
//

#import "GalleryViewHeader.h"
#import "../Models/User.h"

@implementation GalleryViewHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupHelloLabel];
    self.myWorkoutsLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
    [self.myWorkoutsLabel sizeToFit];
    [self.todayCompletionLabel sizeToFit];
}

- (void)setupHelloLabel {
    self.helloLabelBackground.layer.cornerRadius = 26;
    self.helloLabelBackground.layer.masksToBounds = YES;
    self.helloLabel.text = [NSString stringWithFormat:@"Hello %@", [User currentUser][@"displayName"]];
    self.helloLabel.font = [UIFont fontWithName:@"Poppins-medium" size:24];
    [self.helloLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
