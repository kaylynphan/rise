//
//  RegisterViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "RegisterViewController.h"
#import "Parse/Parse.h"
#import "User.h"
#import "GalleryViewController.h"
#import "../Styles.h"
#import "../Views/CustomTextField.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet CustomTextField *nameField;
@property (weak, nonatomic) IBOutlet CustomTextField *emailField;
@property (weak, nonatomic) IBOutlet CustomTextField *usernameField;
@property (weak, nonatomic) IBOutlet CustomTextField *passwordField;
- (IBAction)registerUser:(id)sender;
- (IBAction)didTapLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *nameFieldBackground;
@property (weak, nonatomic) IBOutlet UIView *emailFieldBackground;
@property (weak, nonatomic) IBOutlet UIView *usernameFieldBackground;
@property (weak, nonatomic) IBOutlet UIView *passwordFieldBackground;
@property (weak, nonatomic) IBOutlet UILabel *registerNewUserLabel;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.registerNewUserLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
    
    // must assign text field delegates to 'self' in order to dismiss keyboard upon pressing 'enter'
    self.nameField.delegate = self;
    self.emailField.delegate = self;
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
    /*
    self.nameField.font = [UIFont fontWithName:@"Poppins-regular" size:16];
    self.emailField.font = [UIFont fontWithName:@"Poppins-regular" size:16];
    self.usernameField.font = [UIFont fontWithName:@"Poppins-regular" size:16];
    self.passwordField.font = [UIFont fontWithName:@"Poppins-regular" size:16];
    self.nameFieldBackground.layer.cornerRadius = 15.0;
    self.emailFieldBackground.layer.cornerRadius = 15.0;
    self.usernameFieldBackground.layer.cornerRadius = 15.0;
    self.passwordFieldBackground.layer.cornerRadius = 15.0;
    
    self.nameFieldBackground.layer.borderColor = UIColor.blackColor.CGColor;
    self.emailFieldBackground.layer.borderColor = UIColor.blackColor.CGColor;
    self.usernameFieldBackground.layer.borderColor = UIColor.blackColor.CGColor;
    self.passwordFieldBackground.layer.borderColor = UIColor.blackColor.CGColor;
    
    self.nameFieldBackground.layer.borderWidth = 1.5;
    self.emailFieldBackground.layer.borderWidth = 1.5;
    self.usernameFieldBackground.layer.borderWidth = 1.5;
    self.passwordFieldBackground.layer.borderWidth = 1.5;
     */
    
    [Styles styleEnabledTextField:self.nameField];
    [Styles styleEnabledTextField:self.emailField];
    [Styles styleEnabledTextField:self.usernameField];
    [Styles styleEnabledTextField:self.passwordField];
    
    [Styles addGradientToButton:self.signUpButton];
    [Styles addGradientToButton:self.loginButton];
}


- (IBAction)didTapLogin:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)registerUser:(id)sender {
    // create alert controllers
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
    
    // initialize a user object
    User *newUser = [User user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    newUser.email = self.emailField.text;
    newUser.displayName = self.nameField.text;
    newUser.preferredHour = @7;
    newUser.preferredMinute = @0;
    newUser.notificationsOn = @YES;
    
    // call sign up function on the object
    // signUpInBackgroundWithBlock is an async function
    if ([self.usernameField.text isEqual:@""]) {
        [self presentViewController:nullUsernameAlert animated:YES completion:^{
        }];
    } else if ([self.passwordField.text isEqual:@""]) {
        [self presentViewController:nullPasswordAlert animated:YES completion:^{
        }];
    } else {
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"registerSegue" sender:nil];
                [self.nameField setText:nil];
                [self.emailField setText:nil];
                [self.usernameField setText:nil];
                [self.passwordField setText:nil];
            }
        }];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:true];
    return false;
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"registerSegue"]){
         UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
         GalleryViewController *controller = (GalleryViewController *)navController.topViewController;
         controller.poses = self.poses;
     }
}
*/


@end
