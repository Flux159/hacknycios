//
//  LoginViewController.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "LoginViewController.h"

#import "SignUpViewController.h"
#import "SubmitButton.h"
#import "CALayer+utils.h"
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet SubmitButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceConstraint;

@property (strong, nonatomic) CCARadialGradientLayer *gradientLayer;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor wnRedColor];
    self.containerView.layer.cornerRadius = 5;
    self.gradientLayer = [CCARadialGradientLayer radialGradientInView:self.view];


    RACSignal *formValid = [RACSignal combineLatest:@[self.usernameTextField.rac_textSignal,
                                                      self.passwordTextField.rac_textSignal]
                                             reduce:^(NSString *username, NSString *password)
                            {
                                return @([username isNonBlank] && [password isNonBlank]);
                            }];

    RAC(self.submitButton, enabled) = formValid;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(NSNotification *notification) {
         @strongify(self);
         NSDictionary *userInfo = notification.userInfo;
         NSUInteger animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
         double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
         CGRect frameEndValue = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

         [UIView animateWithDuration:animationDuration delay:0.0 options:animationCurve << 16 animations:^{
             self.bottomSpaceConstraint.constant = 20.0 + self.view.frame.size.height - frameEndValue.origin.y;
             [self.view layoutIfNeeded];
         } completion:nil];
     }];
}

- (IBAction)submitButtonPressed:(id)sender {
}

- (IBAction)createAccountButtonPressed:(id)sender {
    [self.navigationController pushViewController:[[SignUpViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [self.gradientLayer configureGradientInView:self.view];
}

@end
