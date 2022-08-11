//
//  CompletionViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/22/22.
//

#import "CompletionViewController.h"
#import "rise-Swift.h"
#import "../Models/User.h"
#import "../Styles.h"

@interface CompletionViewController ()
@property (strong, nonatomic) AnimationView *successCheckAnimationView;
@property (weak, nonatomic) IBOutlet UILabel *congratsLabel;
@property (weak, nonatomic) IBOutlet AnimationView *animationView;
@property (weak, nonatomic) IBOutlet UIButton *backToHomeButton;
- (IBAction)didTapBackToHome:(id)sender;

@end

@implementation CompletionViewController

static NSString *const kPFUserDisplayName = @"displayName";
static NSString *const kPFUserCompletionDates = @"completionDates";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backToHomeButton setAlpha:0.0];
    [Styles addGradientToButton:self.backToHomeButton];
    
    // hide default navigation bar
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setTitle:nil];
    
    // start animation
    [self playSuccessAnimation];
    
    // adjust label
    [self drawCongratsLabel];
    
    [self uploadCompletionDate];
}

- (void)playSuccessAnimation {
    [self.animationView loadAnimationWithName:@"../success-check"];
    [self.animationView playWithCompletion:^(BOOL) {
        [UIView animateWithDuration:0.35 animations:^{
            [self.backToHomeButton setAlpha:1.0];
        } completion:nil];
    }];
}

- (void)drawCongratsLabel {
    // there should be a user logged in, but just in case, catch null case
    if ([User currentUser] != nil) {
        self.congratsLabel.text = [NSString stringWithFormat:@"Great job completing your daily stretch, %@!", [User currentUser][kPFUserDisplayName]];
    } else {
        self.congratsLabel.text = @"Great job completing your daily stretch!";
    }
    self.congratsLabel.font = [UIFont fontWithName:@"Poppins-regular" size:20];
    [self.congratsLabel sizeToFit];
}

- (void)uploadCompletionDate {
    User *user = [User currentUser];
    if (user != nil) {
        // if the completion dates array is empty
        if (user[kPFUserCompletionDates] == nil) {
            NSMutableArray *userCompletionDates = [[NSMutableArray alloc] init];
            [userCompletionDates addObject:[NSDate date]];
            user[kPFUserCompletionDates] = userCompletionDates;
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error != nil) {
                    NSLog(@"Error uploading today's completion date: %@", error.localizedDescription);
                } else {
                    NSLog(@"Successfully logged today's completion date");
                }
            }];
        } else if ([user[kPFUserCompletionDates] isKindOfClass:[NSArray class]]) {
            NSMutableArray *userCompletionDates = user[kPFUserCompletionDates];
            if ([[userCompletionDates lastObject] isKindOfClass:[NSDate class]]) {
                NSDate *mostRecentDate = [userCompletionDates lastObject];
                // if the user already recorded having stretched today, then don't do anything
                if ([[NSCalendar currentCalendar] isDateInToday:mostRecentDate]) {
                    NSLog(@"User already stretched today.");
                } else {
                    // add current date to array of completion dates
                    [userCompletionDates addObject:[NSDate date]];
                    user[kPFUserCompletionDates] = userCompletionDates;
                    // write modified array of completion dates to Parse
                    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                        if (error != nil) {
                            NSLog(@"Error uploading today's completion date: %@", error.localizedDescription);
                        } else {
                            NSLog(@"Successfully logged today's completion date");
                        }
                    }];
                }
            }
        } else {
            NSLog(@"There was an issue trying to access user's completion dates from Parse.");
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapBackToHome:(id)sender {
    NSLog(@"Tapped Back to Home button");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
