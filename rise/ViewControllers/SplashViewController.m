//
//  SplashViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "SplashViewController.h"
#import "YogaPoseAPIManager.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "GalleryViewController.h"

@interface SplashViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchPoses];

    //self.poses = [[NSMutableArray init] alloc]; // cannot init a class object
}

- (void)fetchPoses {
    UIAlertController *networkAlert = [UIAlertController alertControllerWithTitle:@"Cannot Get Poses" message:@"The internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self fetchPoses];
    }];
    
    [networkAlert addAction:tryAgainAction];
    
    [self.activityIndicator startAnimating];
    
    // new is an alternative syntax to calling alloc init.
    YogaPoseAPIManager *manager = [YogaPoseAPIManager new];
    [manager fetchPoses:^(NSArray *poses, NSError *error) {
        self.poses = poses;
        if (poses != nil) {
            // if the network call is successful, preform the appropriate segue depending on whether there is a user logged in
            if (PFUser.currentUser) {
                NSLog([NSString stringWithFormat:@"The current username is %@", PFUser.currentUser.username]);
                [self performSegueWithIdentifier:@"splashToGallerySegue" sender:nil];
            } else {
                [self performSegueWithIdentifier:@"splashToLoginSegue" sender:nil];
            }
        } else {
            [self presentViewController:networkAlert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
        }
    }];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"splashToGallerySegue"]){
         UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
         GalleryViewController *controller = (GalleryViewController *)navController.topViewController;
         controller.poses = self.poses;
    } else if ([segue.identifier isEqualToString:@"splashToLoginSegue"]){
        // pass poses to LoginViewController to ultimately pass to GalleryViewController
        LoginViewController *controller = (LoginViewController *)segue.destinationViewController;
        controller.poses = self.poses;
   }
}

@end
