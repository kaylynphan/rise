//
//  ContainedButton.h
//  rise
//
//  Created by Kaylyn Phan on 7/19/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContainedButton : UIView

@property (strong, nonatomic) IBOutlet UIButton *button;

- (id) initWithText:(NSString *)text withFontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
