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
    
    self.helloLabelBackground.backgroundColor = [UIColor grayColor];
    self.helloLabelBackground.layer.cornerRadius = 26;
    self.helloLabelBackground.layer.masksToBounds = YES;
    self.helloLabel.text = [NSString stringWithFormat:@"Hello %@", [User currentUser][@"displayName"]];
    self.helloLabel.font = [UIFont fontWithName:@"Poppins-medium" size:24];
    [self.helloLabel sizeToFit];
    
    self.myWorkoutsLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
    
    [self.todayCompletionLabel sizeToFit];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
