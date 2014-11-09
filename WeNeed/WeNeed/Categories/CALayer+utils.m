//
//  CALayer+utils.m
//  WeNeed
//
//  Created by Joe Burgess on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "CALayer+utils.h"
@implementation CCARadialGradientLayer (utils)

+ (CCARadialGradientLayer *) radialGradientInView:(UIView *)view {

    UIColor *colorOne = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.23];
    UIColor *colorTwo = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0];


    CCARadialGradientLayer *radialGradientLayer = [CCARadialGradientLayer layer];
    radialGradientLayer.colors = @[
                                   (id)colorOne.CGColor,
                                   (id)colorTwo.CGColor
                                   ];
    radialGradientLayer.locations = @[@0.5, @1];


    //  headerLayer.locations = locations;

    return radialGradientLayer;
    
}

- (void) configureGradientInView:(UIView *)view
{
    self.frame = view.bounds;
    self.gradientRadius = CGRectGetMidX(view.bounds);
    self.gradientOrigin = view.center;
}

@end
