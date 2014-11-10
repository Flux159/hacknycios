//
//  UIFont+IGTStyles.h
//  WeNeed
//
//  Created by Benjamin Wu on 11/9/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IGTFontSize) {
    IGTFontSizeSmall,
    IGTFontSizeBody,
    IGTFontSizeSubheader,
    IGTFontSizeHeader,
};

@interface UIFont (IGTStyles)

+ (UIFont *)igtRegularFontWithSize:(IGTFontSize)fontSize;
+ (UIFont *)igtDemiBoldFontWithSize:(IGTFontSize)fontSize;
+ (UIFont *)igtMediumFontWithSize:(IGTFontSize)fontSize;
+ (UIFont *)igtBoldFontWithSize:(IGTFontSize)fontSize;

@end
