//
//  UIColor+WeNeedStyles.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "UIColor+WeNeedStyles.h"

@implementation UIColor (WeNeedStyles)

//rgba( 239, 239, 239, 1) -> light grey background of create group page
//rgba( 223, 223, 223, 1) -> light grey background of header/title bar
//rgba( 102, 102, 102, 1) -> text / image content of create group page
//rgba( 254, 50, 50, 1) -> red

+ (UIColor *)wnLightGreyColor {
    return [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
}

+ (UIColor *)wnMediumGreyColor {
    return [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1];
}

+ (UIColor *)wnTextColor {
    return [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
}

+ (UIColor *)wnRedColor {
    return [UIColor colorWithRed:254.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
