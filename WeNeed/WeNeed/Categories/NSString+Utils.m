//
//  NSString+Utils.m
//  WeNeed
//
//  Created by Benjamin Wu on 11/8/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (BOOL)isNonBlank {
    NSCharacterSet *nonwhitespace = [[NSCharacterSet whitespaceCharacterSet] invertedSet];
    NSRange nonwhitespaceRange = [self rangeOfCharacterFromSet:nonwhitespace];
    return (nonwhitespaceRange.location != NSNotFound);
}

@end
