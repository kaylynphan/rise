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
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

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
    
    CAGradientLayer *gradient = [Styles gradientForLargeView:self.view];
    [self.view.layer insertSublayer:gradient atIndex:0];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CreateCustomWorkoutViewController *createVC = [segue destinationViewController];
    createVC.selectVC = self;
}


@end
