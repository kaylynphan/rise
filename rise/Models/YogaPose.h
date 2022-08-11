//
//  YogaPose.h
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface YogaPose : RLMObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSString *description;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)posesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
