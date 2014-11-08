//
//  SignUpViewController.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "SignUpViewController.h"

#import "SubmitButton.h"

#import "NSString+Utils.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet SubmitButton *submitButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceConstraint;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.containerView.layer.cornerRadius = 5;

    RACSignal *formValid = [RACSignal combineLatest:@[self.usernameTextField.rac_textSignal,
                                                      self.passwordTextField.rac_textSignal,
                                                      self.confirmPasswordTextField.rac_textSignal]
                                             reduce:^(NSString *username, NSString *password, NSString *confirmPassword)
                            {
                                return @([username isNonBlank] && [password isNonBlank] && [confirmPassword isNonBlank] && [password isEqualToString:confirmPassword]);
                            }];

    RAC(self.submitButton, enabled) = formValid;

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
             self.bottomSpaceConstraint.constant = 33.0 + self.view.frame.size.height - frameEndValue.origin.y;
             [self.view layoutIfNeeded];
         } completion:nil];
     }];
}
- (IBAction)submitButtonPressed:(id)sender {
//    [self.view endEditing:NO];
}

@end
