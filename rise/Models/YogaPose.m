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

static NSArray *buggyPoses = @[@0, @4, @10, @11, @15, @20, @21, @27, @29, @30, @31, @36, @39, @40, @47];

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.name = dictionary[@"english_name"];
    NSString *imageURLString = dictionary[@"img_url"];
    if (imageURLString != nil) {
        // this is the hunk of the loading time
        UIImage *uiImageFromSVG = [SVGKImage imageWithContentsOfURL:[NSURL URLWithString:imageURLString]].UIImage;
        self.imageData = UIImagePNGRepresentation(uiImageFromSVG);
    }
    return self;
}

// same as old posesWithDictionaries, but instead of writing to local NSArray 'poses', it writes to Realm
+ (NSArray * )posesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *poses = [[NSMutableArray alloc] init];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];

    int index = 0;
    for (NSDictionary *dictionary in dictionaries) {
        NSLog(@"%@", dictionary); // print each 'item' dictionary
        if (![buggyPoses containsObject:@(index)]) {
            YogaPose *pose = [[YogaPose alloc] initWithDictionary:dictionary];
            [realm addObject:pose];
            [poses addObject:pose];
        }
        index++;
    }
    [realm commitWriteTransaction];
    return poses;
}

@end
