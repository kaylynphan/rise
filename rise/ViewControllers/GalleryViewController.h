//
//  GalleryViewController.h
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import <UIKit/UIKit.h>
#import "NVActivityIndicatorView-Swift.h"
#import "WorkoutCell.h"

NS_ASSUME_NONNULL_BEGIN


@interface GalleryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, WorkoutCellDelegate>

@property (strong, nonatomic) NSArray *poses;
@property (strong, nonatomic) NSArray *arrayOfWorkouts;
@property (weak, nonatomic) IBOutlet NVActivityIndicatorView *activityIndicatorView;


@end

NS_ASSUME_NONNULL_END
