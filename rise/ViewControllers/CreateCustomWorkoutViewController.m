//
//  CreateCustomWorkoutViewController.m
//  rise
//
//  Created by Kaylyn Phan on 8/5/22.
//

#import "CreateCustomWorkoutViewController.h"
#import "../Styles.h"

@interface CreateCustomWorkoutViewController ()

@end

@implementation CreateCustomWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradient = [Styles gradientForLargeView:self.view];
    [self.view.layer insertSublayer:gradient atIndex:0];
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

- (IBAction)didTapDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.selectVC dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)didTapChange:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
