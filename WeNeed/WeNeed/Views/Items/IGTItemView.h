//
//  IGTItemView.h
//  WeNeed
//
//  Created by Benjamin Wu on 11/9/14.
//  Copyright (c) 2014 Donner Dungeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGTItemView : UIView

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIImageView *logoImageView;

- (void)addBackgroundWithColor:(UIColor *)color;
- (void)addLogo:(UIImage *)logo title:(NSString *)title;

@end
