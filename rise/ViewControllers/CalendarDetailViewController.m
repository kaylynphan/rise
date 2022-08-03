//
//  CalendarDetailViewController.m
//  rise
//
//  Created by Kaylyn Phan on 8/3/22.
//

#import "CalendarDetailViewController.h"

@interface CalendarDetailViewController ()

@end

@implementation CalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.completionDate != nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEEE, MMM d, yyyy hh:mm aa"];
        NSLog([formatter stringFromDate:self.completionDate]);
    }
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
