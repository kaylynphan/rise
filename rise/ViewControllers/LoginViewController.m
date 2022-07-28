//
//  LoginViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "User.h"
#import "GalleryViewController.h"
#import "../Managers/NotificationManager.h"
#import "../Styles.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet CustomTextField *usernameField;
@property (weak, nonatomic) IBOutlet CustomTextField *passwordField;
- (IBAction)loginUser:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *passwordBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *usernameBackgroundView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFields];
}

- (void)setupFields {
    // must assign text field delegates to 'self' in order to dismiss keyboard upon pressing 'enter'
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
    [Styles styleEnabledTextField:self.usernameField];
    [Styles styleEnabledTextField:self.passwordField];
    
    
    /*
    self.usernameField.font = [UIFont fontWithName:@"Poppins-regular" size:16];
    self.passwordField.font = [UIFont fontWithName:@"Poppins-regular" size:16];
    
    self.usernameBackgroundView.layer.cornerRadius = 15.0;
    self.passwordBackgroundView.layer.cornerRadius = 15.0;
    
    self.usernameBackgroundView.layer.borderColor = UIColor.blackColor.CGColor;
    self.passwordBackgroundView.layer.borderColor = UIColor.blackColor.CGColor;
    self.usernameBackgroundView.layer.borderWidth = 1.5;
    self.passwordBackgroundView.layer.borderWidth = 1.5;
    
    self.usernameBackgroundView.layer.cornerRadius = 16.0;
    self.passwordBackgroundView.layer.cornerRadius = 16.0;
     */
   
    [Styles addGradientToButton:self.loginButton];
    [Styles addGradientToButton:self.signUpButton];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:true];
    return false;
}

- (IBAction)loginUser:(id)sender {
    UIAlertController *nullUsernameAlert = [UIAlertController alertControllerWithTitle:@"Username Required"
                                                                               message:@"Please enter a username."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertController *nullPasswordAlert = [UIAlertController alertControllerWithTitle:@"Password Required"
                                                                               message:@"Please enter a password."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                      }];
    // add the cancel action to the alertController
    [nullUsernameAlert addAction:cancelAction];
    [nullPasswordAlert addAction:cancelAction];
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    if ([self.usernameField.text isEqual:@""]) {
        [self presentViewController:nullUsernameAlert animated:YES completion:^{
        }];
    } else if ([self.passwordField.text isEqual:@""]) {
        [self presentViewController:nullPasswordAlert animated:YES completion:^{
        }];
    } else {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                [self.usernameField setText:nil];
                [self.passwordField setText:nil];
            }
        }];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}
 */


@end
