//
//  User.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "User.h"

#import "User.h"
#import <Parse/PFObject+Subclass.h>

@implementation User

@dynamic displayName;

+ (User *)user {
    return (User *)[PFUser user];
}

@end
