//
//  YogaPoseAPIManager.m
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import "YogaPoseAPIManager.h"
#import "YogaPose.h"
#import <Realm/Realm.h>

@implementation YogaPoseAPIManager

- (id)init {
    self = [super init];

    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    return self;
}

- (void)fetchPoses:(void(^)(NSArray *poses, NSError *error))completion {
    //look for poses in realm
    RLMResults<YogaPose *> *poses = [YogaPose allObjects];
    if (poses.count == 0) {
        NSURL *url = [NSURL URLWithString:@"https://lightning-yoga-api.herokuapp.com/yoga_poses"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
        NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
                // The network request has completed, but failed.
                // Invoke the completion block with an error.
                completion(nil, error);
            }
            else {
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSArray *dictionaries = dataDictionary[@"items"];
                if (dictionaries != nil) {
                    if ([dictionaries isKindOfClass:[NSArray class]]) {
                        NSArray *poses = [YogaPose posesWithDictionaries:dictionaries];
                        completion(poses, nil);
                    } else {
                        NSLog(@"Error: dataDictionary[\"items\"] is not an array.");
                        completion(nil, nil);
                    }
                } else {
                    NSLog(@"Error: dataDictionary[\"items\"] is nil");
                    completion(nil, nil);
                }
            }
        }];
        [task resume];
    } else {
        completion(poses, nil);
    }
}

@end
