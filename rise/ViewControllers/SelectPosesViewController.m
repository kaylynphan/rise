//
//  SelectPosesViewController.m
//  rise
//
//  Created by Kaylyn Phan on 8/4/22.
//

#import "SelectPosesViewController.h"
#import "../Views/YogaPoseCollectionViewCell.h"
#import "../Models/YogaPose.h"
#import <GravitySliderFlowLayout/GravitySliderFlowLayout-Swift.h>
#import "CreateCustomWorkoutViewController.h"
#import "../Styles.h"

@interface SelectPosesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *selectStretchesLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@end

@implementation SelectPosesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    GravitySliderFlowLayout *gravitySliderLayout = [[GravitySliderFlowLayout alloc] initWith:(CGSizeMake(self.collectionView.frame.size.width * 0.8, self.collectionView.frame.size.height * 0.8))];
    self.collectionView.collectionViewLayout = gravitySliderLayout;
    self.selectedPoses = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.poses.count; i++) {
        [self.selectedPoses addObject:@NO];
    }
    
    [Styles addGradientToButton:self.nextButton];
    self.selectStretchesLabel.font = [UIFont fontWithName:@"Poppins-medium" size:30];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.poses.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YogaPoseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"yogaPoseCollectionViewCell" forIndexPath:indexPath];
    YogaPose *pose = [self.poses objectAtIndex:indexPath.row];
    cell.createVC = self;
    cell.isSelectedPose = [self.selectedPoses objectAtIndex:indexPath.row];
    if ([cell.isSelectedPose isEqual:@YES]) {
        [cell.selectorButton setImage:[UIImage imageNamed:@"Filled check"] forState:UIControlStateNormal];
    } else {
        [cell.selectorButton setImage:[UIImage imageNamed:@"Empty check"] forState:UIControlStateNormal];
    }
    cell.row = indexPath.row;
    cell.poseNameLabel.text = pose.name;
    cell.poseImageView.image = [UIImage imageWithData:pose.imageData];
    return cell;
}

- (void)updateSelectedPoseAtIndex:(NSInteger)index withVal:(NSNumber *)val {
    [self.selectedPoses setObject:val atIndexedSubscript:index];
    for (int i = 0; i < self.selectedPoses.count; i++) {
        if ([[self.selectedPoses objectAtIndex:i] isEqual:@YES]) {
            NSLog(@"%@", [NSString stringWithFormat:@"Pose at index %d is selected.", i]);
        }
    }
}

- (IBAction)didTapNext:(id)sender {
    UIAlertController *notEnoughStretchesAlert = [UIAlertController alertControllerWithTitle:@"Not Enough Stretches Selected" message:@"Pick at least 4 stretches to include in your new workout" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            // do nothing
    }];
    [notEnoughStretchesAlert addAction:okAction];
    
    self.posesToSend = [NSMutableArray new];
    self.indicesToSend = [NSMutableArray new];
    for (int i = 0; i < self.selectedPoses.count; i++) {
        if ([[self.selectedPoses objectAtIndex:i] isEqual: @YES]) {
            [self.posesToSend addObject:[self.poses objectAtIndex:i]];
            [self.indicesToSend addObject:@(i)];
        }
    }
    if (self.posesToSend.count < 4) {
        [self presentViewController:notEnoughStretchesAlert animated:YES completion:^{
        }];
    } else {
        [self performSegueWithIdentifier:@"selectStretchesToCreateWorkoutSegue" sender:nil];
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CreateCustomWorkoutViewController *createVC = [segue destinationViewController];
    createVC.selectVC = self;
    createVC.selectedPoses = self.posesToSend;
    createVC.indices = self.indicesToSend;
}


@end
