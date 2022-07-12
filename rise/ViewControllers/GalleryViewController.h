//
//  GalleryViewController.h
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface GalleryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *poses;
@property (strong, nonatomic) NSArray *arrayOfWorkouts;

@end

NS_ASSUME_NONNULL_END
