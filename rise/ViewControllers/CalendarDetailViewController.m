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
@property (weak, nonatomic) IBOutlet CustomTextField *didCompleteTextField;

@end

@implementation CalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.completionDate != nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEEE, MMM d, yyyy hh:mm aa"];
        self.didCompleteTextField.text = [NSString stringWithFormat:@"You completed a stretch on %@. Keep up the great work!", [formatter stringFromDate:self.completionDate]];
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEEE, MMM d, yyyy"];
        self.didCompleteTextField.text = [NSString stringWithFormat:@"%@\nYou did not complete a stretch on this day. Let's work to build stronger habits!", [formatter stringFromDate:self.date]];
    }
    [Styles styleDisabledTextField:self.didCompleteTextField];
    
    [self.didCompleteTextField sizeToFit];
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
