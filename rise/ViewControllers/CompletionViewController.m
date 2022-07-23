//
//  CompletionViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/22/22.
//

#import "CompletionViewController.h"
#import "rise-Swift.h"
#import "../Models/User.h"

@interface CompletionViewController ()
@property (strong, nonatomic) AnimationView *successCheckAnimationView;
@property (weak, nonatomic) IBOutlet UILabel *congratsLabel;
@property (weak, nonatomic) IBOutlet AnimationView *animationView;
@property (weak, nonatomic) IBOutlet UIButton *backToHomeButton;

@end

@implementation CompletionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backToHomeButton setAlpha:0.0];
    [self.backToHomeButton setTintColor:[UIColor opaqueSeparatorColor]];
    [self.backToHomeButton setTitleColor:[UIColor opaqueSeparatorColor] forState:UIControlStateApplication];
    [self.backToHomeButton setTitleColor:[UIColor opaqueSeparatorColor] forState:UIControlStateDisabled];
    self.backToHomeButton.titleLabel.font = [UIFont fontWithName:@"Poppins-regular" size:18];
    
    // start animation
    [self.animationView loadAnimationWithName:@"../success-check"];
    [self.animationView playWithCompletion:^(BOOL) {
        [UIView animateWithDuration:0.35 animations:^{
            [self.backToHomeButton setAlpha:1.0];
        } completion:^(BOOL finished) {
            // nothing
        }];
    }];
    
    // adjust label
    // there should be a user logged in, but just in case, catch null case
    if ([User currentUser] != nil) {
        self.congratsLabel.text = [NSString stringWithFormat:@"Great job completing your daily stretch, %@!", [User currentUser][@"displayName"]];
    } else {
        self.congratsLabel.text = @"Great job completing your daily stretch!";
    }
    self.congratsLabel.font = [UIFont fontWithName:@"Poppins-regular" size:20];
    [self.congratsLabel sizeToFit];
    
    
    
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
