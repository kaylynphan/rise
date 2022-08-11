//
//  SelectedPoseTableViewCell.h
//  rise
//
//  Created by Kaylyn Phan on 8/8/22.
//

#import <UIKit/UIKit.h>
#import "CircleView.h"
#import "CustomTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectedPoseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet CircleView *circleView;
@property (weak, nonatomic) IBOutlet UIImageView *poseImageView;
@property (weak, nonatomic) IBOutlet CustomTextField *poseNameField;


@end

NS_ASSUME_NONNULL_END
