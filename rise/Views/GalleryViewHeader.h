//
//  GalleryViewHeader.h
//  rise
//
//  Created by Kaylyn Phan on 7/14/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GalleryViewHeader : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayCompletionLabel;
@property (weak, nonatomic) IBOutlet UIView *helloLabelBackground;
@property (weak, nonatomic) IBOutlet UILabel *myWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *xOrCheckMarkImage;

@end

NS_ASSUME_NONNULL_END
