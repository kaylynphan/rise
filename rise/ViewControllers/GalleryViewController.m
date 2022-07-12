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
    
    // delete this later: save some workouts into Parse
    /*
    PFObject *workout1 = [PFObject objectWithClassName:@"Workout"];
    workout1[@"name"] = @"Mind and Flow";
    workout1[@"stretches"] = @[@28, @19, @14, @42, @43, @44];
    [workout1 saveInBackground];
    PFObject *workout2 = [PFObject objectWithClassName:@"Workout"];
    workout2[@"name"] = @"Full Body";
    workout2[@"stretches"] = @[@(22), @(37), @(41), @(14), @(2), @(9)];
    [workout2 saveInBackground];
    PFObject *workout3 = [PFObject objectWithClassName:@"Workout"];
    workout3[@"name"] = @"Core Rotation";
    workout3[@"stretches"] = @[@(42), @(25), @(33), @(6), @(7), @(1)];
    [workout3 saveInBackground];
    PFObject *workout4 = [PFObject objectWithClassName:@"Workout"];
    workout4[@"name"] = @"Barre Warmup";
    workout4[@"stretches"] = @[@(16), @(38), @(37), @(28), @(23), @(17)];
    [workout4 saveInBackground];
     */
    
    // perform query
    self.arrayOfWorkouts = [[NSArray alloc] init];
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
            self.arrayOfWorkouts = savedWorkouts;
            NSLog(@"%@", self.arrayOfWorkouts);
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
    cell.titleLabel.text = [NSString stringWithFormat:@"%d: %@", indexPath.row, cell.workout.name];
    cell.workoutImageView.image = nil;
    
    // This works:
    NSLog(@"%@", [NSString stringWithFormat:@"The first stretch has index %@", [cell.workout.stretches objectAtIndex:0]]);
    
    NSString *stringToDisplay = @"Stretches:\n";
    NSMutableArray *arrayOfStretchNames = [[NSMutableArray alloc] init];
    for (long i = 0; i < cell.workout.stretches.count; i++) {
        NSNumber *index = [cell.workout.stretches objectAtIndex:i];
        Pose *poseToList = [self.poses objectAtIndex:[index intValue]];
        stringToDisplay = [stringToDisplay stringByAppendingFormat:@"%@\n", poseToList.name];
        // set image
        if (i == 0) {
            cell.workoutImageView.image = [SVGKImage imageWithData:[[NSData alloc] initWithContentsOfURL:poseToList.imageURL]].UIImage;
        }
    }
    cell.stretchesLabel.text = stringToDisplay;
    [cell.stretchesLabel setNumberOfLines:0];
    [cell.stretchesLabel sizeToFit];
    //NSLog(stringToDisplay);
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfWorkouts.count;
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
