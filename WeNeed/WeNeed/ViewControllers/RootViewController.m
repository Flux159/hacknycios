//
//  RootViewController.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "RootViewController.h"

#import "IGTGroupItemsViewController.h"
#import "SignUpViewController.h"
#import "LoginViewController.h"
#import "IGTBeerView.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UINavigationController *notAuthenticatedNavigationController = [[UINavigationController alloc] initWithRootViewController:[[SignUpViewController alloc] initWithNibName:nil bundle:nil]];
    notAuthenticatedNavigationController.navigationBarHidden = YES;
//    [self presentViewController:notAuthenticatedNavigationController animated:NO completion:nil];
    [self presentViewController:[[IGTGroupItemsViewController alloc] initWithNibName:nil bundle:nil] animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
