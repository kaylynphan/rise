//
//  YogaPoseAPIManager.h
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YogaPoseAPIManager : NSObject

@property (nonatomic, strong) NSURLSession *session;

- (id)init;
- (void)fetchPoses:(void(^)(NSArray *poses, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
