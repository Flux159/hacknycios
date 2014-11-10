//
//  UIFont+IGTStyles.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/9/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "UIFont+IGTStyles.h"

@implementation UIFont (IGTStyles)

+ (CGFloat)sizeFromIGTFontSize:(IGTFontSize)fontSize {
    switch (fontSize) {
        case IGTFontSizeSmall:
            return 16.0;
        case IGTFontSizeBody:
            return 18.0;
        case IGTFontSizeSubheader:
            return 24.0;
        case IGTFontSizeHeader:
            return 30.0;
    }
}

+ (UIFont *)igtRegularFontWithSize:(IGTFontSize)fontSize {
    return [UIFont fontWithName:@"AvenirNext-Regular" size:[self sizeFromIGTFontSize:fontSize]];
}

+ (UIFont *)igtDemiBoldFontWithSize:(IGTFontSize)fontSize {
    return [UIFont fontWithName:@"AvenirNext-DemiBold" size:[self sizeFromIGTFontSize:fontSize]];
}

+ (UIFont *)igtMediumFontWithSize:(IGTFontSize)fontSize {
    return [UIFont fontWithName:@"AvenirNext-Medium" size:[self sizeFromIGTFontSize:fontSize]];
}

+ (UIFont *)igtBoldFontWithSize:(IGTFontSize)fontSize {
    return [UIFont fontWithName:@"AvenirNext-Bold" size:[self sizeFromIGTFontSize:fontSize]];
}

@end
