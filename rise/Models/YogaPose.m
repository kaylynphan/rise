//
//  YogaPose.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "YogaPose.h"
#import <UIKit/UIKit.h>
#import <SVGKit/SVGKit.h>

@implementation YogaPose

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.name = dictionary[@"english_name"];
    NSString *imageURLString = dictionary[@"img_url"];
    //NSInteger id = dictionary[@"id"];
    //self.index = id - 1;
    //self.imageURL = [NSURL URLWithString:imageURLString];
    if (imageURLString != nil) {
        // this is the hunk of the loading time
        //self.image = [SVGKImage imageWithContentsOfURL:self.imageURL].UIImage;
        UIImage *UIImageFromSVG = [SVGKImage imageWithContentsOfURL:[NSURL URLWithString:imageURLString]].UIImage;
        self.imageData = UIImagePNGRepresentation(UIImageFromSVG);
    }
    return self;
}

// same as old posesWithDictionaries, but instead of writing to local NSArray 'poses', it writes to Realm
+ (NSArray * )posesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *poses = [[NSMutableArray alloc] init];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    for (NSDictionary *dictionary in dictionaries) {
        NSLog(@"%@", dictionary); // print each 'item' dictionary
        YogaPose *pose = [[YogaPose alloc] initWithDictionary:dictionary];
        [realm addObject:pose];
        [poses addObject:pose];
    }
    [realm commitWriteTransaction];
    return poses;
}

/*
// dictionaries is an array of dictionaries. In lightning yoga API this is 'items'
+ (NSArray *)posesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *poses = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in dictionaries) {
            NSLog(@"%@", dictionary); // print each 'item' dictionary
            YogaPose *pose = [[YogaPose alloc] initWithDictionary:dictionary];
            [poses addObject:pose];
        }
        return poses;
    }
 */

@end
