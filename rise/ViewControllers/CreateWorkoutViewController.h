//
//  CreateWorkoutViewController.h
//  rise
//
//  Created by Kaylyn Phan on 8/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreateWorkoutViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) NSArray *poses;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
