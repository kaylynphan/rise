//
//  CalendarDetailViewController.m
//  rise
//
//  Created by Kaylyn Phan on 8/3/22.
//

#import "CalendarDetailViewController.h"
#import "../Styles.h"
#import "../Views/CustomTextField.h"

@interface CalendarDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *xOrCheckImage;

@end

@implementation CalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
    // set up date label
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, MMM d, yyyy"];
    self.dateLabel.text = [formatter stringFromDate:self.date];
    [Styles styleLargeLabel:self.dateLabel];
    // set up message label
    if (self.completionDate == nil) {
        [self.xOrCheckImage setImage:[UIImage imageNamed:@"X Mark Component"]];
        self.messageLabel.text = @"You did not complete a stretch on this day. Let's work to build stronger habits!";
    } else {
        [self.xOrCheckImage setImage:[UIImage imageNamed:@"Check Mark Component"]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:mm aa"];
        self.messageLabel.text = [NSString stringWithFormat:@"Daily stretch completed at %@. Keep up the great work!", [formatter stringFromDate:self.completionDate]];
    }
    [self.messageLabel sizeToFit];

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
