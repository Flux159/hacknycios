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
#import <ReactiveCocoa.h>

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet SubmitButton *submitButton;

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
}

@end
