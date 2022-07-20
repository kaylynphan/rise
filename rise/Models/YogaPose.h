//
//  YogaPose.h
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YogaPose : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImage *image;
@property (assign) NSInteger *index;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)posesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
