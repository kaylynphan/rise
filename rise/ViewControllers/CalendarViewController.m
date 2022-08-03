//
//  CalendarViewController.m
//  rise
//
//  Created by Kaylyn Phan on 8/2/22.
//

#import "CalendarViewController.h"
#import "JTCalendar/JTCalendar.h"
#import <Parse/Parse.h>
#import "../Models/User.h"

@interface CalendarViewController ()
@property (weak, nonatomic) IBOutlet JTVerticalCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end

@implementation CalendarViewController

static NSString *const kPFUserCompletionDates = @"completionDates";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calendarManager = [JTCalendarManager new];
    self.calendarManager.delegate = self;
    [self.calendarManager setMenuView:self.calendarMenuView];
    [self.calendarManager setContentView:self.calendarView];
    [self.calendarManager setDate:[NSDate date]];
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    //default
    dayView.hidden = NO;
    
    // hide dates from different months
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // otherwise, default view for dates in this month
    else {
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    // get user completion dates
    User *user = [User currentUser];
    NSArray *completionDates = user[kPFUserCompletionDates];
    // use this predicate to filter for only dates that will appear on the calendar
    NSPredicate *calendarPredicate = [NSPredicate predicateWithBlock:^BOOL(NSDate *date, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSDateComponents *currentMonth = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:dayView.date];
        NSDateComponents *dayToCheck = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:date];
        return ([currentMonth year] == [dayToCheck year]
                && [currentMonth month] == [dayToCheck month]);
    }];
    NSArray *completionDatesInThisMonth = [completionDates filteredArrayUsingPredicate:calendarPredicate];
    
    // custom view for today's date
    if ([self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    
    // if day is in completionDatesInThisMonth
    for (NSDate *completionDate in completionDatesInThisMonth) {
        if ([self.calendarManager.dateHelper date:completionDate isTheSameDayThan:dayView.date]) {
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor grayColor];
        }
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [self.calendarManager reload];
                    } completion:nil];
    
    // Load the previous or next page if touch a day from another month
    if(![self.calendarManager.dateHelper date:self.calendarView.date isTheSameMonthThan:dayView.date]){
        if([self.calendarView.date compare:dayView.date] == NSOrderedAscending){
            [self.calendarView loadNextPageWithAnimation];
        }
        else{
            [self.calendarView loadPreviousPageWithAnimation];
        }
    }
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
