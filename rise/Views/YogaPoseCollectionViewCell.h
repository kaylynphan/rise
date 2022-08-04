//
//  YogaPoseCollectionViewCell.h
//  rise
//
//  Created by Kaylyn Phan on 8/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YogaPoseCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *poseImageView;
@property (weak, nonatomic) IBOutlet UILabel *poseNameLabel;

@end

NS_ASSUME_NONNULL_END
