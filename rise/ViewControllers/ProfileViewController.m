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


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = [User currentUser];
    self.displayNameLabel.text = user[@"displayName"];
    self.usernameLabel.text = user.username;
    self.emailLabel.text = user.email;
    
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
}
@end
