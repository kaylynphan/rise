//
//  SelectedPoseTableFooter.h
//  rise
//
//  Created by Kaylyn Phan on 8/8/22.
//

#import <UIKit/UIKit.h>
#import "../ViewControllers/CreateCustomWorkoutViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectedPoseTableFooter : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
- (IBAction)didTapChange:(id)sender;
- (IBAction)didTapDone:(id)sender;
@property (weak, nonatomic) CreateCustomWorkoutViewController *vc;


@end

NS_ASSUME_NONNULL_END
