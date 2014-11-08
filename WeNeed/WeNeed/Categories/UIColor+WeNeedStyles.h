//
//  UIColor+WeNeedStyles.h
//  WeNeed
//
//  Created by Benjamin Wu on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WeNeedStyles)

+ (UIColor *)wnLightGreyColor;
+ (UIColor *)wnMediumGreyColor;
+ (UIColor *)wnTextColor;
+ (UIColor *)wnRedColor;

// Returns a 1x1 image of the specified color.
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
