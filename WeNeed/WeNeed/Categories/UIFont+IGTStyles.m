//
//  UIFont+IGTStyles.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/9/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "UIFont+IGTStyles.h"

@implementation UIFont (IGTStyles)

// TODO: Make these default sizes
// 16. 18. 24. 30.

+ (UIFont *)igtDefaultFont {
    return [UIFont fontWithName:@"AvenirNext" size:24.0];
}

+ (UIFont *)igtDefaultBoldFont {
    return [UIFont fontWithName:@"AvenirNext-Bold" size:24.0];
}

@end
