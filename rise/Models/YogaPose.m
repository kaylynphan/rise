//
//  YogaPose.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "YogaPose.h"

@implementation YogaPose

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.name = dictionary[@"english_name"];
    NSString *imageURLString = dictionary[@"img_url"];
    NSInteger id = dictionary[@"id"];
    self.index = id - 1;
    self.imageURL = [NSURL URLWithString:imageURLString];
    //self.imageData = [[NSData alloc] initWithContentsOfURL: self.imageURL];
    //[self.imageData base64EncodedDataWithOptions:NSDataBase64DecodingIgnoreUnknownCharacters];
    //[self.imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return self;
}

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

@end
