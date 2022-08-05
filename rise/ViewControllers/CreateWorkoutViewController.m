//
//  CreateWorkoutViewController.m
//  rise
//
//  Created by Kaylyn Phan on 8/4/22.
//

#import "CreateWorkoutViewController.h"
#import "../Views/YogaPoseCollectionViewCell.h"
#import "../Models/YogaPose.h"
#import <GravitySliderFlowLayout/GravitySliderFlowLayout-Swift.h>

@interface CreateWorkoutViewController ()
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation CreateWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    GravitySliderFlowLayout *gravitySliderLayout = [[GravitySliderFlowLayout alloc] initWith:(CGSizeMake(self.collectionView.frame.size.width * 0.8, self.collectionView.frame.size.height * 0.8))];
    self.collectionView.collectionViewLayout = gravitySliderLayout;
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
    cell.poseNameLabel.text = pose.name;
    cell.poseImageView.image = [UIImage imageWithData:pose.imageData];
    return cell;
}

// credit to GravitySlider example (https://github.com/ApplikeySolutions/GravitySlider/blob/master/Example/GravitySliderFlowLayout/ViewController.swift)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint locationFirst = CGPointMake(self.collectionView.center.x + scrollView.contentOffset.x, self.collectionView.center.y + scrollView.contentOffset.y);
    CGPoint locationSecond = CGPointMake(self.collectionView.center.x + scrollView.contentOffset.x + 20, self.collectionView.center.y + scrollView.contentOffset.y);
    CGPoint locationThird = CGPointMake(self.collectionView.center.x + scrollView.contentOffset.x - 20, self.collectionView.center.y + scrollView.contentOffset.y);
    
    NSIndexPath *indexPathFirst = [self.collectionView indexPathForItemAtPoint:locationFirst];
    NSIndexPath *indexPathSecond = [self.collectionView indexPathForItemAtPoint:locationSecond];
    NSIndexPath *indexPathThird = [self.collectionView indexPathForItemAtPoint:locationThird];
    
    if (indexPathFirst == indexPathSecond && indexPathSecond == indexPathThird) {
        if (indexPathFirst.row != self.pageControl.currentPage) {
            self.pageControl.currentPage = indexPathFirst.row % self.poses.count;
            
        }
    }

}
/*
- (void) animateChangingCellForIndexPath:(NSIndexPath *)indexPath {
    [UIView transitionWithView:[self.collectionView cellForItemAtIndexPath:(indexPath.row % self.poses.count)] duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        <#code#>
    } completion:<#^(BOOL finished)completion#>]
}
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
