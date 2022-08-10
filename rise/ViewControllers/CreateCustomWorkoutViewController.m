//
//  CreateCustomWorkoutViewController.m
//  rise
//
//  Created by Kaylyn Phan on 8/5/22.
//

#import "CreateCustomWorkoutViewController.h"
#import "../Styles.h"
#import "../Views/SelectedPoseTableFooter.h"
#import "../Views/SelectedPoseTableViewCell.h"
#import "../Models/YogaPose.h"
#import "../Models/Workout.h"

@interface CreateCustomWorkoutViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SelectedPoseTableFooter *footerView;

@end

@implementation CreateCustomWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradient = [Styles gradientForLargeView:self.view];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.footerView.vc = self;
    self.footerView.nameField.delegate = self;
    self.footerView.descriptionField.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectedPoses.count;
}

- (void)viewDidLayoutSubviews {
    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectedPoseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectedPoseTableViewCell"];
    YogaPose *pose = [self.selectedPoses objectAtIndex:indexPath.row];
    cell.poseImageView.image = [UIImage imageWithData:pose.imageData];
    cell.poseNameField.text = pose.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)done {
    [Workout createNewWorkoutWithPoses:self.indices withName:self.footerView.nameField.text withDescription:self.footerView.descriptionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error uploading new custom workout");
        } else {
            NSLog(@"Uploaded new custom workout!");
        }
    }];
    if (self.presentingViewController.presentingViewController != nil) {
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)change {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:true];
    return false;
}

@end
