//
//  LoginViewController.h
//  rise
//
//  Created by Kaylyn Phan on 7/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property (strong, nonatomic) NSArray *poses;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

NS_ASSUME_NONNULL_END
