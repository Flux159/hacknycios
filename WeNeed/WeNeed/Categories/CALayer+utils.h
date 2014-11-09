//
//  CALayer+utils.h
//  WeNeed
//
//  Created by Joe Burgess on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <CCARadialGradientLayer.h>
#import <UIKit/UIKit.h>
@interface CCARadialGradientLayer (utils)

+ (CCARadialGradientLayer *) radialGradientInView:(UIView *)view;
- (void) configureGradientInView:(UIView *)view;
@end

