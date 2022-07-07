//
//  Pose.h
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pose : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *imageURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)posesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
