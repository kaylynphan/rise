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
@property (strong, nonatomic) NSMutableArray *selectedPoses; //array of booleans that is the size of self.poses

- (void)updateSelectedPoseAtIndex:(NSInteger)index withVal:(NSNumber *)val;

@end

NS_ASSUME_NONNULL_END
