//
//  CreateCustomWorkoutViewController.h
//  rise
//
//  Created by Kaylyn Phan on 8/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreateCustomWorkoutViewController : UIViewController
- (IBAction)didTapChange:(id)sender;
- (IBAction)didTapDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) UIViewController *selectVC;


@end

NS_ASSUME_NONNULL_END
