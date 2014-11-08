//
//  backgroundView.m
//  WeNeed
//
//  Created by Joe Burgess on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "backgroundView.h"

@implementation backgroundView

- (void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 0.93 };
    CGFloat components[8] = { 1.0, 1.0, 1.0, 0.15,  // Start color
        1.0, 1.0, 1.0, 0.0}; // End color

    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);

    CGRect currentBounds = self.bounds;
    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
    CGFloat radius = CGRectGetMidY(currentBounds);
    CGContextDrawRadialGradient(currentContext, glossGradient, midCenter, 0, midCenter, radius, kCGGradientDrawsAfterEndLocation);

    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
}
@end
