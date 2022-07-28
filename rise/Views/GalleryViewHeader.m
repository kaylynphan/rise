//
//  GalleryViewHeader.m
//  rise
//
//  Created by Kaylyn Phan on 7/14/22.
//

#import "GalleryViewHeader.h"
#import "../Models/User.h"
#import "../Styles.h"

@implementation GalleryViewHeader

static NSString *const kPFUserDisplayName = @"displayName";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupHelloLabel];
    self.myWorkoutsLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
    [self.myWorkoutsLabel sizeToFit];
    [self.todayCompletionLabel sizeToFit];
}


- (void)setupHelloLabel {
    self.helloLabel.text = [NSString stringWithFormat:@"Hello %@", [User currentUser][kPFUserDisplayName]];
    [Styles styleLargeLabel:self.helloLabel];
    self.helloLabelBackground.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:248.0/255.0f blue:248.0/255.0f alpha:1.0f];
    self.helloLabelBackground.layer.cornerRadius = 30;
    self.helloLabelBackground.layer.masksToBounds = YES;
}
 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
