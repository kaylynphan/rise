//
//  YogaPoseCollectionViewCell.h
//  rise
//
//  Created by Kaylyn Phan on 8/4/22.
//

#import <UIKit/UIKit.h>
#import "../ViewControllers/CreateWorkoutViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YogaPoseCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *poseImageView;
@property (weak, nonatomic) IBOutlet UILabel *poseNameLabel;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIButton *selectorButton;
@property (strong, nonatomic) NSNumber *isSelectedPose;
@property (assign, nonatomic) NSInteger row;
@property (weak, nonatomic) CreateWorkoutViewController *createVC;
@end

NS_ASSUME_NONNULL_END
