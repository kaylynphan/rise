//
//  ProfileViewController.h
//  rise
//
//  Created by Kaylyn Phan on 7/25/22.
//

#import <UIKit/UIKit.h>
#import "GalleryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) GalleryViewController *parent;

@end

NS_ASSUME_NONNULL_END
