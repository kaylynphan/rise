//
//  GalleryViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "GalleryViewController.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SplashViewController.h"
#import "WorkoutCell.h"
#import "Pose.h"
#import <SVGKit/SVGKit.h>
#import <SVGKit/SVGKImage.h>
#import "Workout.h"


@interface GalleryViewController ()
- (IBAction)didTapLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set up refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];

    // set up table
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // perform query
    self.workouts = [[NSArray alloc] init];
    [self queryWorkouts];
}

- (void)queryWorkouts {
    PFQuery *query = [PFQuery queryWithClassName:@"Workout"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"objectId"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *savedWorkouts, NSError *error) {
        if (savedWorkouts != nil) {
            // do something with the array of object returned by the call
            self.workouts = savedWorkouts;
            NSLog(@"%@", self.workouts);
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // for now, test the table view by showing each pose's image in a cell
    WorkoutCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"WorkoutCell" forIndexPath:indexPath];
    Workout *workout = self.workouts[indexPath.row];
    
    cell.workoutImageView.image = nil;
    cell.titleLabel.text = [NSString stringWithFormat:@"%d: %@", indexPath.row, workout.name];
    
    NSInteger firstPoseIndex = workout.stretches[0];
    Pose *firstPose = self.poses[firstPoseIndex];
    SVGKImage *svgImage = [SVGKImage imageWithData:firstPose.imageData];
    cell.workoutImageView.image = svgImage.UIImage;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.workouts.count;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapLogout:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    self.view.window.rootViewController = loginViewController;
    // logout user
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"Logout Successful");
        }
    }];
}


@end
