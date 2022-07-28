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
static NSString *const kPFUserCompletionDates = @"completionDates";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupHelloLabel];
    self.myWorkoutsLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
    [self.myWorkoutsLabel sizeToFit];
    [self setupCompletionLabel];
}


- (void)setupHelloLabel {
    self.helloLabel.text = [NSString stringWithFormat:@"Hello %@", [User currentUser][kPFUserDisplayName]];
    [Styles styleLargeLabel:self.helloLabel];
    self.helloLabelBackground.backgroundColor = [UIColor colorWithRed:247.0/255.0f green:248.0/255.0f blue:248.0/255.0f alpha:1.0f];
    self.helloLabelBackground.layer.cornerRadius = 30;
    self.helloLabelBackground.layer.masksToBounds = YES;
}

- (void)setupCompletionLabel {
    User *user = [User currentUser];
    if (user != nil) {
        // if the completion dates array is empty
        if (user[kPFUserCompletionDates] == nil) {
            self.todayCompletionLabel.text = @"You have not stretched today.";
            [self.xOrCheckMarkImage setImage:[UIImage imageNamed:@"X Mark Component"]];
        } else if ([user[kPFUserCompletionDates] isKindOfClass:[NSArray class]]) {
            NSMutableArray *userCompletionDates = user[kPFUserCompletionDates];
            if ([[userCompletionDates lastObject] isKindOfClass:[NSDate class]]) {
                NSDate *mostRecentDate = [userCompletionDates lastObject];
                // if the user already recorded having stretched today
                if ([[NSCalendar currentCalendar] isDateInToday:mostRecentDate]) {
                    self.todayCompletionLabel.text = @"You've already stretched today.";
                    [self.xOrCheckMarkImage setImage:[UIImage imageNamed:@"Check Mark Component"]];
                } else {
                    // otherwise the user has not stretched today
                    self.todayCompletionLabel.text = @"You have not stretched today.";
                    [self.xOrCheckMarkImage setImage:[UIImage imageNamed:@"X Mark Component"]];
                }
            }
        } else {
            NSLog(@"There was an issue trying to access user's completion dates from Parse.");
            self.todayCompletionLabel.text = @"You have not stretched today.";
            [self.xOrCheckMarkImage setImage:[UIImage imageNamed:@"X Mark Component"]];
        }
    }
    [self.todayCompletionLabel sizeToFit];
}
 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
