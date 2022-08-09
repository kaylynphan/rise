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

@interface CreateCustomWorkoutViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CreateCustomWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradient = [Styles gradientForLargeView:self.view];
    [self.view.layer insertSublayer:gradient atIndex:0];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectedPoses.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SelectedPoseTableFooter *footerView = [tableView dequeueReusableCellWithIdentifier:@"selectedPoseTableFooter"];
    footerView.vc = self;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 300;
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
    [self dismissViewControllerAnimated:YES completion:^{
        [self.selectVC dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)change {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
