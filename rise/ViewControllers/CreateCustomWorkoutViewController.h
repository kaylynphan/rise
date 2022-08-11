//
//  CreateCustomWorkoutViewController.h
//  rise
//
//  Created by Kaylyn Phan on 8/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreateCustomWorkoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) UIViewController *selectVC;
@property (strong, nonatomic) NSArray *selectedPoses;
@property (strong, nonatomic) NSArray *indices;
- (void)change;
- (void)done;
- (void)showEmptyNameAlert;
- (void)showEmptyDescriptionAlert;

@end

NS_ASSUME_NONNULL_END
