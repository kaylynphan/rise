//
//  ProfileViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/25/22.
//

#import "ProfileViewController.h"
#import "../Models/User.h"
#import "GalleryViewController.h"
#import <Parse/Parse.h>
#import "../Managers/NotificationManager.h"
#import "../Styles.h"
#import "../Views/CustomTextField.h"
#import "rise-Swift.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
- (IBAction)didTapLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileLabel;
@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *riseWillNotifyLabel;
- (IBAction)didTapBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)dateChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet CustomTextField *displayNameField;
@property (weak, nonatomic) IBOutlet CustomTextField *usernameField;
@property (weak, nonatomic) IBOutlet CustomTextField *emailField;
- (IBAction)didTapEdit:(id)sender;
@property (weak, nonatomic) IBOutlet AnimationView *checkAnimationView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
- (IBAction)didTapCheck:(id)sender;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = [User currentUser];
    
    // set up the time button
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm aa"];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.hour = [user[@"preferredHour"] integerValue];
    dateComponents.minute = [user[@"preferredMinute"] integerValue];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    
    [self.datePicker setDate:date];
    
    NSLog(@"%@", [formatter stringFromDate:date]);
    
    [self.scheduleLabel sizeToFit];
    
    self.profileLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
    self.settingsLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
    
    [self.riseWillNotifyLabel sizeToFit];
    
    
    self.displayNameField.delegate = self;
    self.displayNameField.text = user[@"displayName"];
    self.usernameField.text = user.username;
    self.emailField.text = user.email;
    
    [self.displayNameField setClearsOnBeginEditing:YES];
    
    [Styles styleDisabledTextField:self.displayNameField];
    [Styles styleDisabledTextField:self.usernameField];
    [Styles styleDisabledTextField:self.emailField];
    [Styles addGradientToButton:self.logoutButton];
    
    [Styles styleSmallLabel:self.displayNameLabel];
    [Styles styleSmallLabel:self.usernameLabel];
    [Styles styleSmallLabel:self.emailLabel];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:true];
    return false;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    UIAlertController *emptyAlert = [UIAlertController alertControllerWithTitle:@"Display Name Required" message:@"Your display name cannot be empty." preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [self.displayNameField becomeFirstResponder];
    }];
    [emptyAlert addAction:okAction];
    
    if ([self.displayNameField.text isEqual:@""]) {
        [self presentViewController:emptyAlert animated:YES completion:nil];
    } else  {
        [self.checkAnimationView setProgress:0];
        [self.checkAnimationView playWithCompletion:^(BOOL) {
            [self.checkAnimationView setHidden:YES];
            [self.editButton setHidden:NO];
            [self.displayNameField setUserInteractionEnabled:NO];
            [self changeDisplayName];
        }];
    }
}

- (void)changeDisplayName {
    UIAlertController *displayNameChangedAlert = [UIAlertController alertControllerWithTitle:@"Display Name Updated" message:@"Your display name was successfully changed!" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleCancel) handler:nil];
    [displayNameChangedAlert addAction:okAction];
    
    User *user = [User currentUser];
    user[@"displayName"] = self.displayNameField.text;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error uploading new display name: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully updated user's display name");
            [self presentViewController:displayNameChangedAlert animated:YES completion:nil];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapLogout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.parent logout];
    }];
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dateChanged:(id)sender {
    NSLog(@"Finished editing date");
    NSDate *newDate = self.datePicker.date;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:newDate];
    User *user = [User currentUser];
    user[@"preferredHour"] = [NSNumber numberWithInteger:components.hour];
    user[@"preferredMinute"] = [NSNumber numberWithInteger:components.minute];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error uploading new preferred notification time: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully updated user's preferred notification time");
        }
    }];
    
    // update notifications
    NotificationManager *notificationManager = [[NotificationManager alloc] init];
    [notificationManager rescheduleNotificationWithHour:components.hour withMinute:components.minute];
}
- (IBAction)didTapEdit:(id)sender {
    [self.displayNameField setUserInteractionEnabled:YES];
    [self.displayNameField becomeFirstResponder];
    [self.checkAnimationView loadAnimationWithName:@"../finished-editing"];
    [self.checkAnimationView setProgress:0.9];
    [self.editButton setHidden:YES];
    [self.checkAnimationView setHidden:NO];
}

- (IBAction)didTapCheck:(id)sender {
    [self.view endEditing:true];
}

@end
