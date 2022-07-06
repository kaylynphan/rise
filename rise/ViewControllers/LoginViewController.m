//
//  LoginViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "User.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)loginUser:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
            }
        }];
    }
}
@end
