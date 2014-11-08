//
//  LoginViewController.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "LoginViewController.h"

#import "SubmitButton.h"

#import "NSString+Utils.h"
#import <ReactiveCocoa.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet SubmitButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.containerView.layer.cornerRadius = 5;

    RACSignal *formValid = [RACSignal combineLatest:@[self.usernameTextField.rac_textSignal,
                                                      self.passwordTextField.rac_textSignal]
                                             reduce:^(NSString *username, NSString *password)
                            {
                                return @([username isNonBlank] && [password isNonBlank]);
                            }];

    RAC(self.submitButton, enabled) = formValid;
}

@end
