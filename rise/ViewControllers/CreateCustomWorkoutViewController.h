//
//  CreateCustomWorkoutViewController.h
//  rise
//
//  Created by Kaylyn Phan on 8/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreateCustomWorkoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) UIViewController *selectVC;
@property (strong, nonatomic) NSArray *selectedPoses;
- (void)change;
- (void)done;

@end

NS_ASSUME_NONNULL_END
