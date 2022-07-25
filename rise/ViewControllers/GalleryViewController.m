//
//  GalleryViewController.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "GalleryViewController.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "WorkoutCell.h"
#import "YogaPose.h"
#import "Workout.h"
#import "GuideViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "YogaPoseAPIManager.h"
#import <NVActivityIndicatorView/NVActivityIndicatorView-Swift.h>
@import NVActivityIndicatorView;
#import "../Managers/NotificationManager.h"
#import "../Models/User.h"

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
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorColor = [UIColor clearColor];
    [self.activityIndicatorView startAnimating];
    [self.view addSubview:self.activityIndicatorView];
    
    // perform query
    self.arrayOfWorkouts = [[NSArray alloc] init];
    [self queryWorkouts];
    
    User *user = [User currentUser];
    if (user != nil) {
        NotificationManager *notificationManager = [NotificationManager new];
        [notificationManager requestAuthorization:^(BOOL granted) {
            if (granted) {
                NSLog(@"Notifications authorization granted.");
                NSInteger preferredHour = [user[@"preferredHour"] integerValue];
                NSInteger preferredMinute = [user[@"preferredMinute"] integerValue];
                [notificationManager scheduleNotificationWithHour:preferredHour withMinute:preferredMinute];
            }
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    // start fetching images after activity indicator is already on screen
    if (self.poses == nil) {
        [self fetchPoses];
    }
}

- (void)fetchPoses {
    UIAlertController *networkAlert = [UIAlertController alertControllerWithTitle:@"Cannot Get Poses" message:@"The internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self fetchPoses];
    }];
    
    [networkAlert addAction:tryAgainAction];
    
    // new is an alternative syntax to calling alloc init.
    YogaPoseAPIManager *manager = [YogaPoseAPIManager new];
    [manager fetchPoses:^(NSArray *poses, NSError *error) {
        self.poses = poses;
        if (poses != nil) {
            // if the network call is successful
            NSLog(@"Successfully fetched poses");
            [self.activityIndicatorView stopAnimating];
            [self.tableView reloadData];
        } else {
            [self presentViewController:networkAlert animated:YES completion:^{
                NSLog(@"Fetched poses is nil");
            }];
        }
    }];
    //[self.tableView reloadData];
}

- (void)queryWorkouts {
    PFQuery *query = [PFQuery queryWithClassName:@"Workout"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"objectId"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *savedWorkouts, NSError *error) {
        if (savedWorkouts != nil) {
            // do something with the array of object returned by the call
            self.arrayOfWorkouts = savedWorkouts;
            //NSLog(@"%@", self.arrayOfWorkouts);
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self queryWorkouts];
    [refreshControl endRefreshing];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // for now, test the table view by showing each pose's image in a cell
    WorkoutCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"WorkoutCell" forIndexPath:indexPath];
    cell.workout = self.arrayOfWorkouts[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", cell.workout.name];
    cell.workoutImageView.image = nil;
    cell.delegate = self;
    
    for (long i = 0; i < cell.workout.stretches.count; i++) {
        NSNumber *index = [cell.workout.stretches objectAtIndex:i];
        if (self.poses != nil) {
            YogaPose *poseToList = [self.poses objectAtIndex:[index intValue]];
            // set image
            if (i == 0) {
                cell.workoutImageView.image = [UIImage imageWithData:poseToList.imageData];
            }
        }
    }
    [cell.descriptionLabel setNumberOfLines:0];
    cell.descriptionLabel.text = cell.workout[@"description"];
    [cell.descriptionLabel sizeToFit];
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:@"galleryViewHeader"];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfWorkouts.count;
}

- (void)didStartWorkout:(Workout *)workout {
    NSLog(@"didStartWorkout being called from GalleryViewController");
    [self performSegueWithIdentifier:@"startWorkoutSegue" sender:workout];
}


- (IBAction)didTapLogout:(id)sender {
    // logout user
    NSLog(@"Logout tapped");
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"Logout Successful");
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"startWorkoutSegue"]) {
        GuideViewController *guideVC = [segue destinationViewController];
        guideVC.workout = sender;
        guideVC.poses = self.poses;
    }
}

@end
