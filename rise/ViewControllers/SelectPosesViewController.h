//
//  SelectPosesViewController.h
//  rise
//
//  Created by Kaylyn Phan on 8/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectPosesViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) NSArray *poses;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *selectedPoses; //array of booleans that is the size of self.poses
@property (strong, nonatomic) NSMutableArray *posesToSend;
@property (strong, nonatomic) NSMutableArray *indicesToSend;
- (IBAction)didTapNext:(id)sender;

- (void)updateSelectedPoseAtIndex:(NSInteger)index withVal:(NSNumber *)val;

@end

NS_ASSUME_NONNULL_END
