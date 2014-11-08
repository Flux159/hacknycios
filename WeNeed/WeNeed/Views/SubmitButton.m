//
//  SubmitButton.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "SubmitButton.h"

@implementation SubmitButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self setBackgroundImage:[UIColor imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    self.tintColor = [UIColor wnRedColor];
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
}

@end
